//
//  Calculate.swift
//  Calculator
//
//  Created by Sergey on 10.09.2024.
//

import Foundation


struct Calculate {
    func isAllowed(expression: String, operation: Operation) -> Bool {
        return expression.contains(operation.regex())
    }
    
    func calc(expression: String) -> String {
        var result = expression;
        let operations: [Operation] = [Div(), Multi(), Sum()];
        
        for operation in operations {
            while (self.isAllowed(expression: result, operation: operation)) {
                result = result.replacing(operation.regex(), maxReplacements: 1) { match in
                    return operation.replacer(params: match.output)
                }
            }
        }
        let percent = Percent()
        let value = percent.convertToValue(value: result)
        return self.formater(value: value)
    }
    
    func formater(value: Double) -> String {
        let formater = NumberFormatter()
        formater.decimalSeparator = "."
        formater.numberStyle = .decimal
        formater.maximumFractionDigits = 10
        formater.minimumFractionDigits = 0
        
        if let formatedString = formater.string(from: NSNumber(value: value)) {
            return formatedString
        }
        return String(value)
    }
}
