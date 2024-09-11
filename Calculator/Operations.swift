//
//  Operations.swift
//  Calculator
//
//  Created by Sergey on 10.09.2024.
//

import Foundation

protocol Operation {
    func sign() -> Character
    func regex() -> Regex<(Substring, Substring, Substring)>
    func applyOperation(a: Double, b: Double) -> Double
}

extension Operation {
    func toString(number: Double) -> String {
        if (number < 0) {
            return String(number)
        }
        return "+" + String(number)
    }
    
    func replacer(params: (Substring, Substring, Substring)) -> String {
        let a = Double(params.1) ?? 0
        let b = Double(params.2) ?? 0
        return self.toString(number: self.applyOperation(a: a, b: b))
    }
}

struct Multi: Operation {
    func sign() -> Character {
        return "*"
    }
    
    func regex() -> Regex<(Substring, Substring, Substring)> {
        return #/([-+]?\d+\.?\d*)\*([-+]?\d+\.?\d*)/#
    }
    
    func applyOperation(a: Double, b: Double) -> Double {
        return a * b;
    }
}

struct Div: Operation {
    func sign() -> Character {
        return "/"
    }
    
    func regex() -> Regex<(Substring, Substring, Substring)> {
        return #/([-+]?\d+\.?\d*)\/([-+]?\d+\.?\d*)/#
    }
    
    func applyOperation(a: Double, b: Double) -> Double {
        return a / b;
    }
}

struct Sum: Operation {
    func sign() -> Character {
        return "+"
    }
    
    func regex() -> Regex<(Substring, Substring, Substring)> {
        return #/([-+]?\d+\.?\d*)\+([-+]?\d+\.?\d*)/#
    }
    
    func applyOperation(a: Double, b: Double) -> Double {
        return a + b;
    }
}

struct Sub: Operation {
    func sign() -> Character {
        return "-"
    }
    
    func regex() -> Regex<(Substring, Substring, Substring)> {
        return #/([-+]?\d+\.?\d*)\-([-+]?\d+\.?\d*)/#
    }
    
    func applyOperation(a: Double, b: Double) -> Double {
        return a - b;
    }
}
