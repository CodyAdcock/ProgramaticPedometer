//
//  PedometerController.swift
//  CalculatorProgramatic
//
//  Created by Cody on 10/3/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import HealthKit

class PedometerController {
    
    static let shared = PedometerController()
    private init (){}
    
    var stepsTaken: Double = 0
    
    
    let healthStore = HKHealthStore()
    
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        
        
        if HKHealthStore.isHealthDataAvailable(){
            
            let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            
            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
                guard let result = result, let sum = result.sumQuantity() else {
                    completion(0.0)
                    return
                }
                self.stepsTaken = sum.doubleValue(for: HKUnit.count())
                completion(sum.doubleValue(for: HKUnit.count()))
            }
            
            healthStore.execute(query)
        }
    }
    

}
