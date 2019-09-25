//
//  MathExpressionViewModel.swift
//  Calculator
//
//  Created by Danish Aziz on 25/9/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class MathExpressionViewModel: NSObject {

    let operation: [String] = ["+", "-", "*", "/", "X"]
    var expression: String = ""
    var expressionText: String = ""
    var expresssionResult: String = ""
    
    func saveExpress(digit: String, isNumber: Bool = true) {
        if isNumber {
            if let number = Double(digit) {
                self.expresssionResult += ("" + String(number))
            }
        } else {
             self.expresssionResult += (" " + digit + " ")
        }
    }
    
    func calculateExpression(expression: String) -> String {
        let mathExpression = NSExpression(format: expression)
        if let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double {
            return "\(mathValue)"
        }
        return ""
    }
    
    func cleanExpression(expression: String) -> String {
        let removeSpace = expression.replacingOccurrences(of: " ", with: "")
        let replaceMultipleX = removeSpace.replacingOccurrences(of: "X", with: "*")
        let cleanExpression = removeIfLastDigitIsOperation(expression: replaceMultipleX)
        return cleanExpression
    }
    
    func calculate(expression: String) -> String {
        let cleanExpression = self.cleanExpression(expression: expression)
        guard cleanExpression.count > 0 else {
          return ""
        }
        let calculatedValue = self.calculateExpression(expression: cleanExpression)
        return calculatedValue
        
    }
    
    func removeLastDigit(expression: String) -> String {
        if expression.count > 0 {
             return String(expression.dropLast())
        }
        return ""
    }
    
    func removeIfLastDigitIsOperation(expression: String) -> String {
        if operation.contains(String(expression.dropLast())) {
            return removeLastDigit(expression: expression)
        }
        return expression
    }
    
    func isLastDigitIsOperation(expression: String) -> Bool {
        var cleanExp = cleanExpression(expression: expression)
        if !cleanExp.isEmpty {
            let lastDigit = cleanExp.removeLast()
            return operation.contains(String(lastDigit))
        }
        return true
    }
}
