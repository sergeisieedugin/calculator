//
//  ButtonHandler.swift
//  Calculator
//
//  Created by Sergey on 10.09.2024.
//

import Foundation


class ValueController {
    
    func deleteLastOperator(value: String) -> String {
        let symbolsArray = ["+", "-", "/", "*"]
        let lastChar = String(value.last!)
        if (symbolsArray.contains(lastChar)) {
            return removeLast(value: value)
        }
        return value
    }
    
    func addOperation(value: String, symbol: String) -> String {
        let result = deleteLastOperator(value: value)
        if (result == "0") {
            return "0" + symbol
        }
        return result + symbol
    }
    
    func clearAll() -> String {
        return "0"
    }
    
    func printSymbol(incoming: String, value: String) -> String {
        if (String(value.last!) == "%") {
            return value
        }
        
        if (value == "0") {
            return incoming
        }
        return value + incoming
    }
    
    func removeLast(value: String)  -> String {
        let result = String(value.prefix(value.count-1))
        if (result.count == 0) {
            return "0"
        }
        return result
    }
    
    func addPercent(value: String) -> String {
        let regex = #/\d+\.?$/#
        if let match = value.firstMatch(of: regex) {
            return self.printSymbol(incoming: "%", value: value)
        }
        return value
    }
    
    func addDot(value: String) -> String {
        let regex = #/(^|[+\-*\/])\d+$/#
        if let match = value.firstMatch(of: regex) {
            return self.printSymbol(incoming: ".", value: value)
        }
        return value
    }
    
}
