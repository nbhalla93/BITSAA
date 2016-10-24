//
//  HealthManager.swift
//  BAMC
//
//  Created by Nikita Bhalla on 18/10/16.
//  Copyright © 2016 BITSAA. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthManagerDelegate {
    func dataUpdated()
}


class HealthManager {
    
    static let sharedInstance = HealthManager()

    let healthKitStore:HKHealthStore = HKHealthStore()
    var heightString = ""
    var stepCount = 0
    var calorie = 0
    var delegate: HealthManagerDelegate?
    
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
    
    func updateDailyStepCount() {
        
        let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount)

        let query = HKObserverQuery(sampleType: sampleType!, predicate: nil) { (query, completionHandler, error) in
            if error != nil {
                
                // Perform Proper Error Handling Here...
                print("*** An error occured while setting up the stepCount observer. \(error?.localizedDescription) ***")
                abort()
            }
            
            // Take whatever steps are necessary to update your app's data and UI
            // This may involve executing other queries
            self.getStepCount()
            
            // If you have subscribed for background updates you must call the completion handler here.
            // completionHandler()
            
        }
        
        healthKitStore.execute(query)
    }
    
    func getStepCount() {
        
        let startDate = Calendar.current.startOfDay(for: Date())
        
        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)
        let interval = NSDateComponents()
        interval.day = 1
        let query = HKStatisticsCollectionQuery(quantityType: quantityType!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate as Date, intervalComponents:interval as DateComponents)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                
                //  Something went Wrong
                return
            }
            
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate, to: endDate as Date) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let step = quantity.doubleValue(for: HKUnit.count())
                        
                        self.stepCount = Int(step)
                        self.delegate?.dataUpdated()

                        
                    }
                }
            }
            
            
        }
        
        
        healthKitStore.execute(query)
    }

    
    func updateCalorieCount() {
        
        let sampleType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)
        
        let query = HKObserverQuery(sampleType: sampleType!, predicate: nil) { (query, completionHandler, error) in
            if error != nil {
                
                // Perform Proper Error Handling Here...
                print("*** An error occured while setting up the stepCount observer. \(error?.localizedDescription) ***")
                abort()
            }
            
            // Take whatever steps are necessary to update your app's data and UI
            // This may involve executing other queries
            self.getCalorieCount()
            
            // If you have subscribed for background updates you must call the completion handler here.
            // completionHandler()
            
        }
        
        healthKitStore.execute(query)
    }
    
    func getCalorieCount() {
        
        let startDate = Calendar.current.startOfDay(for: Date())
        
        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)
        let interval = NSDateComponents()
        interval.day = 1
        let query = HKStatisticsCollectionQuery(quantityType: quantityType!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate as Date, intervalComponents:interval as DateComponents)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                
                //  Something went Wrong
                return
            }
            
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate, to: endDate as Date) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let step = quantity.doubleValue(for: HKUnit.calorie())
                        
                        self.calorie = Int(step) / 1000
                        self.delegate?.dataUpdated()
                        
                        
                    }
                }
            }
            
            
        }
        
        
        healthKitStore.execute(query)
    }

    func getCalorieCount(startDate: Date, endDate: Date, comletion: @escaping ((Int) -> Void)) {

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let quantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)
        let interval = NSDateComponents()
        interval.day = 1
        let query = HKStatisticsCollectionQuery(quantityType: quantityType!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate as Date, intervalComponents:interval as DateComponents)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                
                //  Something went Wrong
                return
            }
            
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate, to: endDate as Date) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let calorie = quantity.doubleValue(for: HKUnit.calorie())/1000
                        
                        comletion(Int(calorie))
                        
                    }
                }
            }
            
            
        }
        
        
        healthKitStore.execute(query)
    }
}
