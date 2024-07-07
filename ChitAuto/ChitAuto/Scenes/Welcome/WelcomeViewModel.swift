//
//  WelcomeViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import Foundation
import Network
import Firebase

final class WelcomeViewModel {
    //    MARK: - Properties
    let whyCaruDesc: String = "ChitAuto არის მანქანის შეკეთების სწორი გზა. 7 საათის ნაცვლად 5 წუთს ხარჯავ, უფრო იაფი გიჯდება და თან მანქანას მცოდნე ადამიანი აკეთებს. ამიტომ თუნდაც ChitAuto არ იყოს და სხვა ჩვენი მსგავსი კომპანია იყოს. გირჩევთ ის გამოიყენოთ და თქვენით არ წაიყვანოთ მანქანა შესაკეთებლად თუ ავტომობილებში ძალიან კარგად არ ერკვევით. და ამას გეუბნებით ხალხი ვისაც ავტოსერვისში 10+წლიანი გამოცდილება გვაქვს"
    let economyTitle: String = "დროის ეკონომია"
    let economyDesc: String = "კვლევებმა აჩვენა რომ საშუალოდ მანქანის შესაკეთებლად მეპატრონეს ჭირდება 7.5 საათი. ChitAuto - ს გამოყენებისას ხარჯავ მხოლოდ 5 წუთს."
    let warrantyTitle: String = "გარანტია"
    let warrantyDesc: String = "გაუთვალისწინებელი შემთხვევებისთვის გვაქვს საგარანტიო ფონდი, რომლითაც ანაზღაურდება ზარალი"
    let insuranceTitle: String = "დაზღვევა"
    let insuranceDesc: String = "შენი ავტომობილი დაზღვეული იქნება, სანამ ის ავტო ასისტენტის ხელშია"
    let howDoesItWorks: String = "როგორ მუშაობს?"
    let whyCaru: String = "რატომ ქარუ?"
    let assistantImage: String = "https://caru.ge/assets/images/why/poster.png"
    
    var carRepairPhases: [RepairPhase] = []
    
    var carRepairPhasesCount: Int {
        carRepairPhases.count
    }
    
    var currentUser: User? = nil
    
    //    MARK: - Api Urls
    private let phasesUrl: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/phases.json"
    
    //    MARK: - Initialization
    init() {
        fetchData()
        fetchUser()
    }
    
    //    MARK: - Delegates
    weak var reloadCollectionViewDelegate: ReloadCollectionViewDelegate?
    
    //    MARK: - Child Method
    
    //    MARK: - Requests
    private func fetchData() {
        NetworkService.networkService.getData(urlString: phasesUrl) { [weak self] (result: Result<CarRepairPhases, Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let phases):
                    self?.carRepairPhases = phases.phases
                case .failure(let error):
                    print("DEBUG: Can't Fetch Data From CarRepairPhases" + error.localizedDescription)
                }
                self?.reloadCollectionViewDelegate?.reloadData()
            }
        }
    }
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { [weak self] (documentSnapshot, error) in
            guard let self = self else { return }
            guard let document = documentSnapshot else {
                print("DEBUG: Error fetching user data: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let user = try document.data(as: User.self)
                self.currentUser = user
                print(currentUser)
            } catch {
                print("DEBUG: Error decoding user data: \(error.localizedDescription)")
            }
        }
    }
    //    MARK: - Firebase Functions
    
}
