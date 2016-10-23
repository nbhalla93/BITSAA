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
    
    func dataTypesToWrite() -> Set<HKSampleType> {
        let heightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let weightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let dietaryCalorieEnergyType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let activeEnergyBurnType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        return Set([heightType, weightType, dietaryCalorieEnergyType, activeEnergyBurnType])
    }
    
    func dataTypesToRead() -> Set<HKObjectType> {
        let heightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let weightType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let dietaryCalorieEnergyType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!
        let activeEnergyBurnType: HKQuantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        return Set([heightType, weightType, dietaryCalorieEnergyType, activeEnergyBurnType])
    }
    
    func authorizeHealthKit(completion: ((_ successVal:Bool,_ errorVal:NSError?) -> Void)!)
    {
//        if HKHealthStore.isHealthDataAvailable() {
//            let dataToRead = dataTypesToRead()
//            let dataToWrite = dataTypesToWrite()
//            
//            healthKitStore.requestAuthorization(toShare: dataToWrite, read: dataToRead, completion: { (success, error) in
//                completion(true, error)
//            })
//        }
        
        let error = NSError(domain: "com.BMAC.healthkit", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
        if( completion != nil )
        {
            completion(false, error)
        }
        return;
    }

//    func updateHeight() {
//        let heightInMs = 1.70
//        let startDate: Date
//        let endDate: Date
//        
//        let date = Date()
//        let quantityType = HKQuantityType.quantityType(forIdentifier: .height)
//        let quantity = HKQuantity(unit: HKUnit.meter(), doubleValue: heightInMs)
//        
//        let heightSample = HKQuantitySample(type: quantityType!, quantity: quantity, start: startDate, end: endDate)
//        
//        healthKitStore.save(heightSample) { (success, error) in
//            
//        }
//    }
//    
//    func updateWeight() {
//        let weightInGrams = 83400.0
//        let startDate: Date
//        let endDate: Date
//        
//        let date = Date()
//        let quantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass)
//        let quantity = HKQuantity(unit: HKUnit.gram(), doubleValue: weightInGrams)
//        
//        let weightSample = HKQuantitySample(type: quantityType!, quantity: quantity, start: startDate, end: endDate)
//        
//        healthKitStore.save(weightSample) { (success, error) in
//            
//        }
//        
//    }
//    
//    func getStepCount() {
//        let startDate: Date
//        let endDate: Date
//        
//        let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount)
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//        
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
//        
//        let sampleQuery = HKSampleQuery(sampleType: sampleType!, predicate: predicate, limit: HKObjectQueryNoLimit,
//                                        sortDescriptors: [sortDescriptor]) { (query, result, error) in
//                                            if (result != nil) && (error == nil) {
//                                                for samples in result! {
//                                                    
//                                                }
//                                            }
//        }
//        healthKitStore.execute(sampleQuery)
//    }
}
