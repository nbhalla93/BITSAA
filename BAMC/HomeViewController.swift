//
//  HomeViewController.swift
//  BAMC
//
//  Created by Nikita Bhalla on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var calorieCount: UILabel!
    @IBOutlet weak var stepCount: UILabel!
    
    let healthManager = HealthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.sharedInstance.getLeaders { (leaders) in
            print("got leaders = \(leaders)")
        }
        
    }
}
