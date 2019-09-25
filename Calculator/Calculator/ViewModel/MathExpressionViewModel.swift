//
//  MathExpressionViewModel.swift
//  Calculator
//
//  Created by Danish Aziz on 25/9/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class MathExpressionViewModel: NSObject {

    let operation: [String] = ["+", "-", "*", "/", "X", "%"]
    let point: String = "."
    var expressionArray: [String] = []
    
    var expressionText: String {
        return getExpressionText()
    }
    
    var expression: String {
        return getExpression()
    }
    
    func saveExpress(digit: String, isNumber: Bool = true) {
        
        if isValueIsOperation(value: digit) {
            expressionArray.append(digit)
            return
        }
        
        if let lastNumbers = expressionArray.last, !isLastDigitIsOperation(expression: lastNumbers) {
            if !lastNumbers.contains(point) || !digit.elementsEqual(point) {
                expressionArray[expressionArray.count - 1] += digit
            }
        } else {
            expressionArray.append(digit)
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
    
    func calculate() -> String {
        let expression = getExpression()
        if !expression.isEmpty {
            let cleanExpression = self.cleanExpression(expression: expression)
            guard !cleanExpression.isEmpty && !self.isLastDigitIsOperation(expression: cleanExpression) else {
                return ""
            }
            let calculatedValue = self.calculateExpression(expression: cleanExpression)
            return calculatedValue
        }
        return expression
    }
    
    func removeLastDigit() {
        if let value = expressionArray.last {
            expressionArray[expressionArray.count - 1] = String(value.dropLast())
            if expressionArray[expressionArray.count - 1].isEmpty {
                expressionArray.removeLast()
            }
        }
    }
    
    func removeIfLastDigitIsOperation(expression: String) -> String {
        if operation.contains(String(expression.dropLast())) {
            self.removeLastDigit()
            return self.expressionText
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
    
    func isValueIsOperation(value: String) -> Bool {
        return operation.contains(value)
    }
    
    func isLastDigitIsPoint() -> Bool {
        let expression = getExpressionText()
        var cleanExp = cleanExpression(expression: expression)
        if !cleanExp.isEmpty {
            let lastDigit = cleanExp.removeLast()
            return self.point.elementsEqual(String(lastDigit))
        }
        return true
    }
    
    func getExpression() -> String {
        var expression = ""
        for value in expressionArray {
            if isValueIsOperation(value: value) {
                if value.elementsEqual("%") {
                     expression += "/100 *"
                } else {
                     expression += value
                }
            } else {
                if let digits = Double(value) {
                    expression += String(digits)
                }
            }
        }
        return expression
    }
    
    func getExpressionText() -> String {
        var expression = ""
        for value in expressionArray {
            if isValueIsOperation(value: value) {
                expression += String(format: " %@", value)
            } else {
                expression += String(format: " %@", value)
            }
        }
        return expression
    }
    
    func clearAll() {
        self.expressionArray.removeAll()
    }
}
