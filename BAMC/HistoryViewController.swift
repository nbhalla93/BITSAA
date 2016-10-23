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
    let index = 0
    @IBOutlet weak var prev: UIButton!
    @IBOutlet weak var goNext: UIButton!
    let calories = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    @IBAction func goToPreviousDay(_ sender: AnyObject) {

    }
    
    @IBAction func goToNextDay(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prev.isEnabled = false
    
        let comps = Calendar.current.component(Calendar.Component.day, from: Date())
        
    }
    
    func indexChanged(value: Int) {
        if value == 0 {
            prev.isEnabled = false
        }
        
        if value == 14 {
            goNext.isEnabled = false
        }
        
//        currentDate = calorieList.value(forKey: String(value)).date
        
    }
    
}
