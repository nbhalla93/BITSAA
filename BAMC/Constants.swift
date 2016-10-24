//
//  Constants.swift
//  BAMC
//
//  Created by Nikita Bhalla on 24/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation

func getCurrentDay() -> Int {
    return Calendar.current.component(Calendar.Component.day, from: Date())
}

func modifyCalorieListTableWithValue(value: Int) -> NSMutableArray{
    let date = getCurrentDay()
    
    if let calorieTable = UserDefaults.standard.value(forKey: ktable) as? NSMutableArray {
        calorieTable[date - 1] = value
        UserDefaults.standard.set(calorieTable, forKey: ktable)
        return calorieTable
    }
    return []
}

