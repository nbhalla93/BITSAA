//
//  HealthManager.swift
//  BAMC
//
//  Created by Nikita Bhalla on 18/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
    let healthKitStore:HKHealthStore = HKHealthStore()
    var heightString = ""
    let stepCount = 0
    
    func dataTypesToWrite() -> Set<HKSampleType> {
        let heightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let weightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        return Set([heightType, weightType])
    }
    
    func dataTypesToRead() -> Set<HKObjectType> {
        let heightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let weightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let dietaryCalorieEnergyType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let activeEnergyBurnType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        return Set([heightType, weightType, dietaryCalorieEnergyType, activeEnergyBurnType])
    }
    
    func authorizeHealthKit(completion: ((Bool?, NSError?) -> Void)?) {
        if HKHealthStore.isHealthDataAvailable() {
            let dataToRead = dataTypesToRead()
            let dataToWrite = dataTypesToWrite()
            
            healthKitStore.requestAuthorization(toShare: dataToWrite, read: dataToRead, completion: { (success, error) in
                completion?(success, error as NSError?)
            })
        }
        return;
    }

    func updateHeight(startDate: Date, endDate: Date, heightInMs: Double) {
        let quantityType = HKQuantityType.quantityType(forIdentifier: .height)
        let quantity = HKQuantity(unit: HKUnit.meter(), doubleValue: heightInMs)
        
        let heightSample = HKQuantitySample(type: quantityType!, quantity: quantity, start: startDate, end: endDate)
        
        healthKitStore.save(heightSample) { (success, error) in
            
        }
    }
    
    func updateWeight(startDate: Date, endDate: Date, weightInGrams: Double) {
        let quantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass)
        let quantity = HKQuantity(unit: HKUnit.gram(), doubleValue: weightInGrams)
        
        let weightSample = HKQuantitySample(type: quantityType!, quantity: quantity, start: startDate, end: endDate)
        
        healthKitStore.save(weightSample) { (success, error) in
            
        }
        
    }
    
    func getStepCount(startDate: Date, endDate: Date) {
        
        let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        

        let query = HKObserverQuery(sampleType: sampleType!, predicate: predicate) {
            query, completionHandler, error in
            
            if error != nil {
                
                // Perform Proper Error Handling Here...
                print("*** An error occured while setting up the stepCount observer. \(error?.localizedDescription) ***")
                abort()
            }
            
//            stepCount =
            
            // If you have subscribed for background updates you must call the completion handler here.
             completionHandler()
        }
        
        healthKitStore.execute(query)
    }
}
