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
    
    func setup() {
        if DeviceConfig().isIPad() {
            lblExpression.font = lblExpression.font.withSize(50)
            lblResult.font = lblResult.font.withSize(66)
        }
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
            if !self.viewModel.isLastDigitIsOperation(expression: self.viewModel.expression) {
                self.viewModel.saveExpress(digit: buttonText, isNumber: false)
                self.setExpresionLabel(doCalculation: false)
            }
        }
    }
    
    @IBAction func pressRemoveButton(_ sender: UIButton) {
        self.viewModel.removeLastDigit()
        self.setExpresionLabel(doCalculation: true)
    }
    
    @IBAction func pressPointButton(_ sender: UIButton) {
         if let buttonText = sender.titleLabel?.text {
            if !self.viewModel.isLastDigitIsPoint() {
                self.viewModel.saveExpress(digit: buttonText)
                self.setExpresionLabel(doCalculation: true)
            }
        }
    }
    
    @IBAction func pressAllClear(_ sender: UIButton) {
        lblExpression.text = ""
        lblResult.text = ""
        self.viewModel.clearAll()
    }
    
    @IBAction func pressEqual(_ sender: UIButton) {
        if !self.viewModel.isLastDigitIsOperation(expression: self.viewModel.expression) {
            lblResult.text = self.viewModel.calculate()
            lblExpression.text = ""
            self.viewModel.clearAll()
        }
    }

    func setExpresionLabel(doCalculation: Bool = true) {
        self.lblExpression.text = self.viewModel.expressionText
        if doCalculation {
             self.lblResult.text = self.viewModel.calculate()
        }
    }
}

