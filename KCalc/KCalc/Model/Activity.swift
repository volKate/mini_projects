//
//  ActivityMenu.swift
//  KCalc
//
//  Created by Kate Volkova on 8.08.22.
//

import Foundation

enum Activity {
    enum Gender: String {
        case Male = "male", Female = "female"
    }
    
    case Sedentary, Active
    case LowActive(gender: Gender)
    case VeryActive(gender: Gender)
    
    init(rawValue: String, gender: Gender) {
        switch rawValue {
        case "Sedentary":
            self = .Sedentary
        case "Low active":
            self = .LowActive(gender: gender)
        case "Active":
            self = .Active
        case "Very active":
            self = .VeryActive(gender: gender)
        default:
            self = .Sedentary
        }
    }
    
    var label: String {
        switch self {
        case .Sedentary:
            return "Sedentary"
        case .LowActive:
            return "Low active"
        case .Active:
            return "Active"
        case .VeryActive:
            return "Very active"
        }
    }
    
    var coefficient: Double {
        switch self {
        case .Sedentary:
            return 1.0
        case .Active:
            return 1.27
        case .LowActive(let gender) where gender == .Female:
            return 1.14
        // LowActive gender == .Male
        case .LowActive:
            return 1.12
        case .VeryActive(let gender) where gender == .Female:
            return 1.45
        // VeryActive gender == .Male
        case .VeryActive:
            return 1.54
        }
    }
}
