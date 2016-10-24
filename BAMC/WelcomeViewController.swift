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
            as! WelcomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = UserDefaults.standard.value(forKey: kname) as! String
        name.text = user
    }
    
    @IBAction func `continue`(_ sender: AnyObject) {
        DispatchQueue.main.async { [weak self ] in
            guard let strongSelf = self else { return }
            let storyBoard = UIStoryboard(name: "LogInViewController", bundle: nil)
            let controller = storyBoard.instantiateInitialViewController()
            strongSelf.present(controller!, animated: true, completion: nil)
        }
    }
}
