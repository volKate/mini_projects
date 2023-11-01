//
//  CalorieCalculator.swift
//  KCalc
//
//  Created by Kate Volkova on 8.08.22.
//

import Foundation

let constantCoeffiecients = [[
    Activity.Gender.Male: 864,
    Activity.Gender.Female: 387
], [
    Activity.Gender.Male: 9.72,
    Activity.Gender.Female: 7.31
], [
    Activity.Gender.Male: 14.2,
    Activity.Gender.Female: 10.9
], [
    Activity.Gender.Male: 503,
    Activity.Gender.Female: 660.7
]]

struct CalorieCalculator {
    
    let height: Double
    let weight: Double
    let age: Double
    let activity: Activity
    
    // constant coefficients based on Gender
    let baseCoef: Double
    let ageCoef: Double
    let weightCoef: Double
    let heightCoef: Double
    
    
    init(height: Int, weight: Int, age: Int, activity: String, gender: Activity.Gender) {
        self.height = Double(height) / 100 // formula requires height in meters
        self.weight = Double(weight)
        self.age = Double(age)
        self.activity = Activity(rawValue: activity, gender: gender)
        
        
        self.baseCoef = constantCoeffiecients[0][gender]!
        self.ageCoef = constantCoeffiecients[1][gender]!
        self.weightCoef = constantCoeffiecients[2][gender]!
        self.heightCoef = constantCoeffiecients[3][gender]!
    }
    
    func getCaloriesPerDay() -> Int {
        let kcal = baseCoef - ageCoef * age + activity.coefficient * (weightCoef * weight + heightCoef * height)
        return Int(kcal)
    }
}
