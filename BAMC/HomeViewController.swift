//
//  HomeViewController.swift
//  BAMC
//
//  Created by Nikita Bhalla on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, HealthManagerDelegate {
    @IBOutlet weak var calorieCount: UILabel!
    @IBOutlet weak var stepCount: UILabel!
    
    let healthManager = HealthManager()
    
    @IBAction func syncWithServer(_ sender: AnyObject) {
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        APIService.sharedInstance.submitCal(name: "Stupid Nikita", email: "i-am-hot@gmail.com", calories: "[1,2,3,4]") { (total) in
            
            print("yay !! total calories burnt = \(total)")
        }
//        healthManager.authorizeHealthKit { [weak self ] (success, error) in
//            guard let strongSelf = self else { return }
//            
//            if error != nil {
//
//                print("Error in authorizing")
//            } else if success! {
//                print("AUthorized successfully")
//                strongSelf.healthManager.updateDailyStepCount()
//                strongSelf.healthManager.updateCalorieCount()
//            }
//        }
//            
//        healthManager.delegate = self
//        
//        healthManager.updateDailyStepCount()
//        healthManager.updateCalorieCount()
    }
    
    func dataUpdated() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.stepCount.text = String(strongSelf.healthManager.stepCount)
            strongSelf.calorieCount.text = String(strongSelf.healthManager.calorie)
        }
    }
}
