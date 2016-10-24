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
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var progressViewbar: UIProgressView!
    
    let healthManager = HealthManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        healthManager.authorizeHealthKit { [weak self ] (success, error) in
            guard let strongSelf = self else { return }
            
            if error != nil {

                print("Error in authorizing")
            } else if success! {
                print("AUthorized successfully")
                strongSelf.healthManager.updateDailyStepCount()
                strongSelf.healthManager.updateCalorieCount()
            }
        }
            
        healthManager.delegate = self
        syncWithServer(nil)
    }
    
    
    @IBAction func syncWithServer(_ sender: AnyObject?) {
        
        getCalorieString()

    }
    
    func getCalorieString() {
        var totalCalorie = 0
            var comps = DateComponents()
            comps.day = 22
            comps.month = 10
            comps.year = 2016
            let datey = Calendar.current.date(from: comps)
            let startDate = Calendar.current.startOfDay(for: datey!)
            let endDate = Date(timeInterval: 1296000, since: startDate)
            
            
            HealthManager.sharedInstance.getCalorieCount(startDate: startDate, endDate: endDate, comletion: { [weak self] value in
                guard let strongSelf = self else { return }
                totalCalorie += value
                let stringValue = "[" + String(totalCalorie) + ",0]"
                strongSelf.syncValue(stringValue: stringValue)
            })
    }
    
    func syncValue(stringValue: String) {
        let name = UserDefaults.standard.value(forKey: kname) as! String
        let email = UserDefaults.standard.value(forKey: kemail) as! String
        
        
        APIService.sharedInstance.submitCal(name: name, email: email, calories: stringValue) { [weak self] value in
            guard let strongSelf = self else { return }
            let val: Int = (Int(value)! / 1000000) * 100
            strongSelf.percentage.text = String(val)
            strongSelf.progressViewbar.progress = Float(value)!/1000000
        }

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
