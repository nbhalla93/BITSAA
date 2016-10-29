//
//  SignUpViewController.swift
//  BAMC
//
//  Created by Nikita Bhalla on 09/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
//    let service = RegistrationService()
    
    @IBAction func signUp(_ sender: AnyObject) {
        
        
        if let nameS = name.text, let numberS = mobileNumber.text, let mailS = emailID.text, let passS = password.text {
            
            if isStringWithAnyText(object: name.text!) && isStringWithAnyText(object: mobileNumber.text!) && isStringWithAnyText(object: emailID.text!)
                && isStringWithAnyText(object: password.text!)
            {
                UserDefaults.standard.set(name.text, forKey: kname)
                UserDefaults.standard.set(emailID.text, forKey: kemail)
                
                APIService.sharedInstance.signUp(name: nameS, email: mailS, phone: numberS, password: passS, completion: { [weak self] name in
                    guard let strongSelf = self else { return }
                    let view = WelcomeViewController.instantiateFromStoryboard()
                    DispatchQueue.main.async {
                        strongSelf.present(view, animated: true, completion: nil)
                        
                    }
                    
                    
                    })

            } else {
                let alert = UIAlertController(title: "Required Fields Missing", message: "All the fields are required to sign up", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                return
            }
            
            
            
            
        } else {
            let alert = UIAlertController(title: "Required Fields Missing", message: "All the fields are required to sign up", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)

            present(alert, animated: true, completion: nil)
            return
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldsImage()
    }
    
    func setTextFieldsImage() {
        name.rightViewMode = .always
        name.rightView = UIImageView(image: UIImage(named: "ic_perm_identity_black_24dp"))
        
        mobileNumber.rightViewMode = .always
        mobileNumber.rightView = UIImageView(image: UIImage(named: "ic_phone_black_24dp"))
        
        emailID.rightViewMode = .always
        emailID.rightView = UIImageView(image: UIImage(named: "ic_mail_outline_black_24dp"))
        
        password.rightViewMode = .always
        password.rightView = UIImageView(image: UIImage(named: "ic_lock_outline_black_24dp"))
        
    }
    
    func isStringWithAnyText(object: String) -> Bool {
        if !(object is String) || object.isEqual(NSNull()) || object.isEqual("null") {
            return false
        }
        
        // swiftlint:disable:next force_cast
        let string = object as! String
        let trimmed = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.characters.count > 0
    }
}
