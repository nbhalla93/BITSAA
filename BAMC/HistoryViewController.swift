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
    var index = 0
    @IBOutlet weak var prev: UIButton!
    @IBOutlet weak var goNext: UIButton!
    var calories = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
//    let day = Calendar.current.component(Calendar.Component.day, from: Date())
    let day = 1
    
    @IBAction func goToPreviousDay(_ sender: AnyObject) {
        if index > 1 {
            prev.isEnabled  = true
            index -= 1
            currentDate.text = String(index) + "/11"
            numberOfCalories.text = String(calories[index - 1])
        } else {
            prev.isEnabled = false
        }
    }
    
    @IBAction func goToNextDay(_ sender: AnyObject) {
        if index < 15 {
            goNext.isEnabled  = true
            index += 1
            currentDate.text = String(index) + "/11"
            numberOfCalories.text = String(calories[index - 1])
        } else {
            goNext.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        updateFromOldData()
        
        if day < 15 {
            currentDate.text = String(day) + "/11"
            numberOfCalories.text = String(calories[day - 1])
        }
        index = day
    }
    
    func updateFromOldData() {
        if let calorieTable = UserDefaults.standard.value(forKey: ktable) as? NSArray {
            for i in 0...14 {
                calories[i] = calorieTable[i] as! Int
            }
        }
    }
}
