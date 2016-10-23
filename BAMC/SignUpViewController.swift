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
        var user = User()
        
        if let nameS = name.text, let numberS = mobileNumber.text, let mailS = emailID.text, let passS = password.text {
            user = User(sampleName: nameS, number: numberS, mail: mailS, pass: passS)
            UserDefaults.standard.set(user, forKey: kuser)
        } else {
            let alert = UIAlertController(title: "Required Fields Missing", message: "All the fields are required to sign up", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let url = URL(string: "http://bamc.netne.net/registration.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "name=\(user.name)&password=\(user.password)&email=\(user.emailID)&number=\(user.mobileNumber)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Request is: \(request)")
            print("Request body is : \(request.httpBody)")
            print("Response is: \(response)")
            print("Data is : \(data)")
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    
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
}
