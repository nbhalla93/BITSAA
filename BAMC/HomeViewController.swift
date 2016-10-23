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
    
    @IBAction func stepCOunt(_ sender: AnyObject) {
        healthManager.updateDailyStepCount()
        healthManager.updateCalorieCount()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthManager.authorizeHealthKit { (success, error) in
            if error != nil {
//                let error = NSError(domain: "com.BMAC.healthkit", code: 2,
//                userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])

                print("Error in authorizing")
            } else if success! {
                print("AUthorized successfully")
            }
        }
        healthManager.delegate = self
    }
    
    func dataUpdated() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.stepCount.text = String(strongSelf.healthManager.stepCount)
            strongSelf.calorieCount.text = String(strongSelf.healthManager.calorie)
        }
    }
}
