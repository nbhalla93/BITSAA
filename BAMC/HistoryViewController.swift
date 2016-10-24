//
//  HistoryViewController.swift
//  BAMC
//
//  Created by Nikita Bhalla on 23/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import UIKit

typealias tupleVal = (cal: String, date: String)

class HistoryViewController: UIViewController {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var numberOfCalories: UILabel!
    var calorieList: NSDictionary = [:]
    var dayIndex = 1
    @IBOutlet weak var prev: UIButton!
    @IBOutlet weak var goNext: UIButton!
    
    var calories = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    let day = Calendar.current.component(Calendar.Component.day, from: Date())
    let month = Calendar.current.component(Calendar.Component.month, from: Date())

    let healthManager = HealthManager.sharedInstance

    @IBAction func goToPreviousDay(_ sender: AnyObject) {
        if dayIndex > 0  {
            prev.isEnabled  = true
            dayIndex -= 1
            currentDate.text = String(dayIndex) + "/" + String(month)
            self.numberOfCalories.text = "0"
            updateCalorieCount(day: dayIndex, month: month)
        } else {
            prev.isEnabled = false
        }
    }
    
    @IBAction func goToNextDay(_ sender: AnyObject) {
        if dayIndex < 30  {
            goNext.isEnabled  = true
            dayIndex += 1
            currentDate.text = String(dayIndex) + "/" + String(month)
            self.numberOfCalories.text = "0"
            updateCalorieCount(day: dayIndex, month: month)
        } else {
            prev.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        currentDate.text = String(day) + "/" + String(month)
        updateCalorieCount(day: day, month: month)
        dayIndex = day
    }
    
    func updateCalorieCount(day: Int, month: Int) {
        var comps = DateComponents()
        comps.day = day
        comps.month = month
        comps.year = 2016
        let datey = Calendar.current.date(from: comps)
        let startDate = Calendar.current.startOfDay(for: datey!)
        let endDate = Date(timeInterval: 86400, since: startDate)
        
        healthManager.getCalorieCount(startDate: startDate, endDate: endDate, comletion: { calorieValue in
            DispatchQueue.main.async {
                self.numberOfCalories.text = String(calorieValue)

            }
            
        })

    }
    
}
