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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = UserDefaults.standard.value(forKey: kuser) as! User
        name.text = user.name
    }
}
