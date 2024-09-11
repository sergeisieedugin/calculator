//
//  Calculate.swift
//  Calculator
//
//  Created by Sergey on 10.09.2024.
//

import Foundation


struct Calculate {
    func isNotEnd(expression: String, operation: Character) -> Bool {
        if let index = expression.lastIndex(of: operation) {
            let position = expression.distance(from: expression.startIndex, to: index)
            return position > 0
        }
        
        return false
    }
    
    func calc(expression: String) -> Double {
        var result = expression;
        let operations: [Operation] = [Div(), Multi(), Sum(), Sub()];
        
        for operation in operations {
            while (self.isNotEnd(expression: result, operation: operation.sign())) {
                result = result.replacing(operation.regex()) { match in
                    return operation.replacer(params: match.output)
                }
            }
        }
        
        return Double(result) ?? 0
    }
}
