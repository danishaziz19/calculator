//
//  ViewController.swift
//  Calculator
//
//  Created by Danish Aziz on 25/9/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblExpression: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    let viewModel: MathExpressionViewModel = MathExpressionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup()
    }
    
    // setup iPad font
    func setup() {
        if DeviceConfig().isIPad() {
            lblExpression.font = lblExpression.font.withSize(50)
            lblResult.font = lblResult.font.withSize(66)
        }
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    
    }
    
    // Press Number button
    @IBAction func pressNumberButton(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text {
            self.viewModel.saveExpression(digit: buttonText)
            self.setLabelValue()
        }
    }
    
    // Press Operation button ( * , / , + , -)
    @IBAction func pressOperationButton(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text {
            if !self.viewModel.isLastDigitIsOperation(expression: self.viewModel.expression) {
                self.viewModel.saveExpression(digit: buttonText, isNumber: false)
                self.setLabelValue(doCalculation: false)
            }
        }
    }
    
    // Press Remove button to remove last digit from expression
    @IBAction func pressRemoveButton(_ sender: UIButton) {
        self.viewModel.removeLastDigit()
        self.setLabelValue(doCalculation: true)
    }
    
    // Press Point button
    // Checking in expression has point already there or not if point is already there
    // it will not add point again for this digit
    @IBAction func pressPointButton(_ sender: UIButton) {
         if let buttonText = sender.titleLabel?.text {
            if !self.viewModel.isLastDigitIsPoint() {
                self.viewModel.saveExpression(digit: buttonText)
                self.setLabelValue(doCalculation: true)
            }
        }
    }
    
    // Press Clear All.
    // Clear whole expression values
    @IBAction func pressAllClear(_ sender: UIButton) {
        lblExpression.text = ""
        lblResult.text = ""
        self.viewModel.clearAll()
    }
    
    // Press Equal Button
    // It will calculate and show result values and clear expression label
    @IBAction func pressEqual(_ sender: UIButton) {
        if !self.viewModel.isLastDigitIsOperation(expression: self.viewModel.expression) {
            lblResult.text = self.viewModel.calculate()
            lblExpression.text = ""
            self.viewModel.clearAll()
        }
    }

    // Set Label values.
    // if doCalculation is true it will also calculate the result and show if doCalculation is
    // false it will only update expression
    func setLabelValue(doCalculation: Bool = true) {
        self.lblExpression.text = self.viewModel.expressionText
        if doCalculation {
             self.lblResult.text = self.viewModel.calculate()
        }
    }
}

