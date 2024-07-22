//
//  TechInspectViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import SwiftSoup
import Foundation

final class TechInspectViewModel {
    var numberPlate: String = ""
    
    var pastDate: String = ""
    var futureDate: String = ""
    
    //MARK: - Methods
    func getTechInspectInfo(completion: @escaping (Bool) -> Void) {
        sendPostRequest(registrationNumber: numberPlate) { [weak self] pastDate, futureDate, success in
            if success {
                // Assign values
                self?.pastDate = pastDate ?? ""
                self?.futureDate = futureDate ?? ""
                
                // Check if either date is nil or empty
                if let pastDate = pastDate, let futureDate = futureDate, !pastDate.isEmpty, !futureDate.isEmpty {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    //MARK: - Child Method
    // Function to extract information from HTML
   private func extractInfo(from htmlString: String) -> (String?, String?) {
        do {
            let document: Document = try SwiftSoup.parse(htmlString)
            
            // Extract the specific paragraphs
            let firstParagraph = try document.select("p.date.title").first()
            let secondParagraph = try document.select("p.date").last()
            
            let firstText = try firstParagraph?.text()
            let secondText = try secondParagraph?.text()
            
            return (firstText, secondText)
        } catch Exception.Error(_, let message) {
            print("Message: \(message)")
            return (nil, nil)
        } catch {
            print("error")
            return (nil, nil)
        }
    }
    //MARK: - Requests
    // Define a function to send the POST request
    private func sendPostRequest(registrationNumber: String, completion: @escaping (String?, String?, Bool) -> Void) {
        var formatedRegistrationNumber = registrationNumber
        formatedRegistrationNumber.removeAll(where: {$0 == "-"})
        
        // URL of the endpoint
        let url = URL(string: "https://greenway.ge/ka/Home/CalculatePrice")!
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the body parameters
        let bodyParameters = [
            "__RequestVerificationToken": "USh_jE_P_f2SLVDsvqW2tNY307mcbzcYiHJMFgjBxXeRDFPtqlcWHIdAMPkI6hwk8vJAk-kbKu7WcajeLbjC-aq6qkc5vXCaHnhXJZpE-8Y1",
            "RegistrationNumber": formatedRegistrationNumber
        ]
        
        // Convert the parameters to Data
        let bodyData = bodyParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)!
        request.httpBody = bodyData
        
        // Set the headers
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Create the URLSession data task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            // Handle errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, nil, false)
                return
            }
            
            // Ensure there is data
            guard let data = data else {
                print("No data")
                completion(nil, nil, false)
                return
            }
            
            // Parse the JSON response
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let htmlString = json["html"] as? String {
                    // Extract information from the HTML
                    guard let unwrappedTuple = self?.extractInfo(from: htmlString) else { return }
                    
                    let (firstPart, secondPart) = unwrappedTuple
                    completion(firstPart, secondPart, true)
                } else {
                    print("Invalid JSON")
                    completion(nil, nil, false)
                }
            } catch {
                print("JSON Parsing Error: \(error.localizedDescription)")
                completion(nil, nil, false)
            }
        }
        // Start the task
        task.resume()
    }
    
    //MARK: - Navigation

}
