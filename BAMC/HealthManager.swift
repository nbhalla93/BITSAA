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
    var stepCount = 0
    
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
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

        let query = HKObserverQuery(sampleType: sampleType!, predicate: nil) { (query, completionHandler, error) in
            if error != nil {
                
                // Perform Proper Error Handling Here...
                print("*** An error occured while setting up the stepCount observer. \(error?.localizedDescription) ***")
                abort()
            }
            
            // Take whatever steps are necessary to update your app's data and UI
            // This may involve executing other queries
            self.updateDailyStepCount()
            
            // If you have subscribed for background updates you must call the completion handler here.
            // completionHandler()
            
        }
        
        healthKitStore.execute(query)
    }
    
    func updateDailyStepCount() {
        let startDate = Date()
        let endDate = Date(timeInterval: 2592000, since: startDate)
        let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType!, predicate: predicate, limit: HKObjectQueryNoLimit,
                                        sortDescriptors: [sortDescriptor]) { (query, result, error) in
                                            if (result != nil) && (error == nil) {
                                                let mostRecentSample = result?.first as? HKQuantitySample
                                                
                                                if let count = mostRecentSample?.quantity.doubleValue(for: HKUnit.count()) {
                                                    self.stepCount = Int(count)
                                                }
                                            }
        }
        healthKitStore.execute(sampleQuery)
    }
}
