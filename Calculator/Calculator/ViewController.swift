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
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation.isLandscape)
    }
    
    @IBAction func pressNumberButton(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text {
            self.viewModel.saveExpress(digit: buttonText)
            self.setExpresionLabel()
        }
    }
    
    @IBAction func pressOperationButton(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text {
            if let expression = lblExpression.text {
                if !self.viewModel.isLastDigitIsOperation(expression: expression) {
                    self.viewModel.saveExpress(digit: buttonText, isNumber: false)
                    self.setExpresionLabel(doCalculation: false)
                }
            }
        }
    }
    
    @IBAction func pressRemoveButton(_ sender: UIButton) {
        if let expression = self.lblExpression.text {
            lblExpression.text = self.viewModel.removeLastDigit(expression: expression)
        }
    }
    
    @IBAction func pressPointButton(_ sender: UIButton) {
         if let buttonText = sender.titleLabel?.text {
            if !self.viewModel.isLastDigitIsPoint() {
                self.viewModel.saveExpress(digit: buttonText)
            }
        }
    }
    
    @IBAction func pressAllClear(_ sender: UIButton) {
        lblExpression.text = ""
        lblResult.text = ""
        self.viewModel.clearAll()
    }
    
    @IBAction func pressEqual(_ sender: UIButton) {
        if let expression = self.lblExpression.text, !expression.isEmpty {
            if !self.viewModel.isLastDigitIsOperation(expression: expression) {
                lblResult.text = self.viewModel.calculate()
                lblExpression.text = ""
                self.viewModel.clearAll()
            }
        }
    }

    func setExpresionLabel(doCalculation: Bool = true) {
        self.lblExpression.text = self.viewModel.expressionText
        if doCalculation {
             self.lblResult.text = self.viewModel.calculate()
        }
    }
}

