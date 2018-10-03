//
//  SubmissionController.swift
//  CalculatorProgramatic
//
//  Created by Cody on 10/2/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class SubmissionController{
    static let shared = SubmissionController()
    private init(){}
    
    var submission = Submission(miles: 0, kilometers: 0, steps: 0)
    
    func fromMiles(miles: Double){
        submission.miles = miles
        submission.steps = miles * Constants.stepsInMile
        submission.kilometers = miles * Constants.kmInMile
        
    }
    func fromKilometers(kilometers: Double){
        submission.kilometers = kilometers
        submission.miles = kilometers / Constants.kmInMile
        submission.steps = kilometers * Constants.stepsInKM
        
    }
    func fromSteps(steps: Double){
        submission.steps = steps
        submission.miles = steps / Constants.stepsInMile
        submission.kilometers = steps / Constants.stepsInKM
    }
    
}

struct Constants{
    static let stepsInMile: Double = 2000
    static let stepsInKM: Double = 1312
    static let kmInMile: Double = 1.61
}
