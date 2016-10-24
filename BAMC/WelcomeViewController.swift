//
//  WelcomeViewController.swift
//  BAMC
//
//  Created by Nikita Bhalla on 09/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    
    class func instantiateFromStoryboard() -> WelcomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
            // swiftlint:disable:next force_cast
            as! WelcomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = UserDefaults.standard.value(forKey: kuser) as! User
        name.text = user.name
    }
    
    @IBAction func `continue`(_ sender: AnyObject) {
        let calorieTable = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        UserDefaults.standard.set(calorieTable, forKey: ktable)
        
        let homeScreen = HomeScreenTabBarController.instantiateFromStoryboard()
        present(homeScreen, animated: true, completion: nil)
    }
}
