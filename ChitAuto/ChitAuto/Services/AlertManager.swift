//
//  AlertManager.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 20.07.24.
//

import UIKit

class AlertManager {
    private static func showTextAlert(on vc: UIViewController,
                                      with title: String,
                                      with message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "კარგი", style: .cancel, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showAddCarDetailsIsNotValid(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "მანქანას ვერ დაამატებთ", with: "თქვენს მიერ შეყვანილი ინფორმაცია არის არასრული, გთხოვთ სცადოთ თავიდან.")
    }
    
    public static func showCurrentCarHasOrder(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "ასისტენტს ვერ გამოიძახებთ", with: "ამ მანქანისთვის უკვე გამოძახებული გყავთ ასისტენტი.")
    } 
    
    public static func showCanNotUpdateOrderCarInfo(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "ინფორმაციას ვერ დაამატებთ", with: "თქვენს მიერ შეყვანილი ინფორმაცია არის არასრული, გთხოვთ სცადოთ თავიდან.")
    } 
    
    public static func showCanNotUpdateOrderAssistant(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "ასისტენტი არ აგირჩევია", with: "გთხვოთ,აირჩიოთ ასისტენტი")
    }
    
    public static func showCanNotUpdateProfilePicture(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "სურათი იტვრითება", with: "გთხვოთ,დაელოდოთ სურათის განახლებას")
    }
    
    public static func showCanNotShowTechInspectInfo(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "ფორმატი არასწორია", with: "გთხოვთ,მანქანის ნომერი შეიყვანოთ სწორი ფორმატით")
    }
}


//MARK: - Button Alerts
extension AlertManager {
    private static func showButtonAlert(on vc: UIViewController,
                                        title: String,
                                        message: String,
                                        button1: UIAlertAction,
                                        button2: UIAlertAction) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(button1)
        alert.addAction(button2)
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showDeleteConfirmation(on vc: UIViewController, completion: @escaping (Bool) -> Void) {
        let button1 = UIAlertAction(title: "უკან", style: .cancel) { _ in
            completion(false)
        }
        
        let button2 = UIAlertAction(title: "გაუქმება", style: .destructive) { _ in
            completion(true)
        }
        
        self.showButtonAlert(on: vc, title: "შეკვეთის გაუქმება", message: "დარწმუნებული ხარ რომ გინდა გაუქმება?", button1: button1, button2: button2)
    }
}
