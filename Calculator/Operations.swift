//
//  Operations.swift
//  Calculator
//
//  Created by Sergey on 10.09.2024.
//

import Foundation

protocol Operation {
    func regex() -> Regex<(Substring, Substring, Substring, Substring)>
    func applyOperation(a: Double, b: Double) -> Double
    func replacer(params: (Substring, Substring, Substring, Substring)) -> String
}

extension Operation {
    func toString(number: Double) -> String {
        if (number < 0) {
            return String(number)
        }
        return "+" + String(number)
    }
    
    func replacer(params: (Substring, Substring, Substring, Substring)) -> String {
        let percent = Percent()
        let a = percent.convertToValue(value: String(params.1))
        let baseValue = ["*", "/"].contains(String(params.2)) ? 1 : a
        let b = percent.convertToValue(value: String(params.3), baseValue: baseValue)
        return self.toString(number: self.applyOperation(a: a, b: b))
    }
}

struct Percent {
    func isPercent(value: String) -> Bool {
        let lastChar = String(value.last!)
        return lastChar == "%"
    }
    
    func convertToValue(value: String, baseValue: Double = 1.0) -> Double {
        if (self.isPercent(value: value)) {
            return self.calcPercent(value: self.getClearValue(value: value), baseValue: baseValue)
        }
        return Double(value) ?? 0
    }
    
    func getClearValue(value: String) -> Double {
        let result = String(value.dropLast())
        return Double(result) ?? 0
    }
    
    func calcPercent(value: Double, baseValue: Double = 1.0) -> Double {
        return value * baseValue / 100
    }
}

struct Multi: Operation {
    
    func regex() -> Regex<(Substring, Substring, Substring, Substring)> {
        return #/([-+]?\d+\.?\d*%?)(\*)([-+]?\d+\.?\d*%?)/#
    }
    
    func applyOperation(a: Double, b: Double) -> Double {
        return a * b;
    }
}

struct Div: Operation {
    
    func regex() -> Regex<(Substring, Substring, Substring, Substring)> {
        return #/([-+]?\d+\.?\d*%?)(\/)([-+]?\d+\.?\d*%?)/#
    }
    
    func applyOperation(a: Double, b: Double) -> Double {
        return a / b;
    }
}

struct Sum: Operation {

    func regex() -> Regex<(Substring, Substring, Substring, Substring)> {
        return #/([-+]?\d+\.?\d*%?)([-+])([-+]?\d+\.?\d*%?)/#
    }
    
    func applyOperation(a: Double, b: Double) -> Double {
        return a + b
    }
    
    func minusOperation (a: Double, b: Double) -> Double {
        return a - b
    }
    
    func replacer(params: (Substring, Substring, Substring, Substring)) -> String {
        let percent = Percent()
        let a = percent.convertToValue(value: String(params.1))
        let baseValue = a
        let b = percent.convertToValue(value: String(params.3), baseValue: baseValue)
        if (params.2 == "-") {
            return self.toString(number: self.minusOperation(a: a, b: b))
        }
        return self.toString(number: self.applyOperation(a: a, b: b))
    }
}

