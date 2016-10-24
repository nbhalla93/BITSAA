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
    var calorie = 0
    var step = 0
    
    let healthManager = HealthManager()
    
    @IBAction func syncWithServer(_ sender: AnyObject) {
        
        let table = modifyCalorieListTableWithValue(value: calorie)
        
        APIService.sharedInstance.submitCal(name: "Nikita", email: "yay@gmail.com", calories: "[1,2,3,4]") { (total) in
            
            print("yay !! total calories burnt = \(total)")
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
            strongSelf.calorie = strongSelf.healthManager.calorie
            strongSelf.step = strongSelf.healthManager.stepCount
        }
    }
    
    func updateLocalTable() {
        
    }
}
