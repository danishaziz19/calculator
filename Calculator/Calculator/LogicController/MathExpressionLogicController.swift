//
//  MathExpressionLogicController.swift
//  Calculator
//
//  Created by Danish Aziz on 25/9/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class MathExpressionLogicController: NSObject {

    let operation: [String] = ["+", "-", "*", "/", "X", "%"]
    let point: String = "."
    var expressionArray: [String] = []
    
    var expressionText: String {
        return getExpressionText()
    }
    
    var expression: String {
        return getExpression()
    }
    
    // Save Expression
    func saveExpression(digit: String, isNumber: Bool = true) {
        
        if isValueOperation(value: digit) {
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
    
    // Calculate Expression and reture result
    func calculate() -> String {
        let expression = getExpression()
        if !expression.isEmpty {
            let cleanExpression = self.cleanExpression(expression: expression)
            guard !cleanExpression.isEmpty && !self.isLastDigitIsOperation(expression: cleanExpression) else {
                return ""
            }
            let calculatedValue = self.calculateExpression(expression: cleanExpression)
            return getResult(value: calculatedValue)
        }
        return expression
    }
    
    // check last digit in expression is operation or not
    func isLastDigitIsOperation(expression: String) -> Bool {
        var cleanExp = cleanExpression(expression: expression)
        if !cleanExp.isEmpty {
            let lastDigit = cleanExp.removeLast()
            return operation.contains(String(lastDigit))
        }
        return true
    }
    
    // Check value is operation or not
    func isValueOperation(value: String) -> Bool {
        return operation.contains(value)
    }
    
    // check last digit is point in expression
    func isLastDigitIsPoint() -> Bool {
        let expression = getExpressionText()
        var cleanExp = cleanExpression(expression: expression)
        if !cleanExp.isEmpty {
            let lastDigit = cleanExp.removeLast()
            return self.point.elementsEqual(String(lastDigit))
        }
        return true
    }
    
    // Clear all expression
    func clearAll() {
        self.expressionArray.removeAll()
    }
    
    // Remove last digit from expression
    func removeLastDigit() {
        if let value = expressionArray.last {
            expressionArray[expressionArray.count - 1] = String(value.dropLast())
            if expressionArray[expressionArray.count - 1].isEmpty {
                expressionArray.removeLast()
            }
        }
    }
    
    // Get result check if value is Double or Int
   private func getResult(value: String) -> String {
        let values = value.components(separatedBy: ".")
        if let number = Int(values.last ?? "0"), number <= 0 {
            return "\((value as NSString).integerValue)"
        }
        return value
    }
    
    // Generate Expression from Array
    private func getExpression() -> String {
        var expression = ""
        for value in expressionArray {
            if isValueOperation(value: value) {
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
    
    //Generate Expression from Array to show
    private func getExpressionText() -> String {
        var expression = ""
        for value in expressionArray {
            if isValueOperation(value: value) {
                expression += String(format: " %@", value)
            } else {
                expression += String(format: " %@", value)
            }
        }
        return expression
    }
    
    // Calculate Expression
    private func calculateExpression(expression: String) -> String {
        let mathExpression = NSExpression(format: expression)
        if let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double {
            return "\(mathValue)"
        }
        return ""
    }
    
    // Remove space and replace X to * (Multiply)
    private func cleanExpression(expression: String) -> String {
        let removeSpace = expression.replacingOccurrences(of: " ", with: "")
        let replaceMultipleX = removeSpace.replacingOccurrences(of: "X", with: "*")
        let cleanExpression = removeLastDigitIfOperation(expression: replaceMultipleX)
        return cleanExpression
    }
    
    // Remove last digit if its operation to calulate value.
    // PS: We are removing operation as a last digit coz gives error while using NSExpression
    private func removeLastDigitIfOperation(expression: String) -> String {
        if operation.contains(String(expression.dropLast())) {
            self.removeLastDigit()
            return self.expressionText
        }
        return expression
    }
}
