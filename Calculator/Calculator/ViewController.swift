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
    
    @IBAction func pressEqual(_ sender: Any) {
         if let expression = self.lblExpression.text, !expression.isEmpty {
            if !self.viewModel.isLastDigitIsOperation(expression: expression) {
                lblResult.text = self.viewModel.calculate(expression: expression)
                lblExpression.text = ""
            }
        }
    }
    
    @IBAction func pressNumberButton(_ sender: Any) {
        if let buttonText = (sender as? UIButton)?.titleLabel?.text {
            self.viewModel.saveExpress(digit: buttonText)
            lblExpression.text = (lblExpression.text ?? "") + buttonText
            if let expression = self.lblExpression.text, !expression.isEmpty {
                lblResult.text = self.viewModel.calculate(expression: expression)
            }
        }
    }
    
    @IBAction func pressOperationButton(_ sender: Any) {
        if let buttonText = (sender as? UIButton)?.titleLabel?.text {
            if let expression = lblExpression.text {
                if !self.viewModel.isLastDigitIsOperation(expression: expression) {
                    self.viewModel.saveExpress(digit: buttonText, isNumber: false)
                    lblExpression.text = (lblExpression.text ?? "") + " " + buttonText + " "
                }
            }
        }
    }
    
    @IBAction func pressRemoveButton(_ sender: Any) {
        if let expression = self.lblExpression.text {
            lblExpression.text = self.viewModel.removeLastDigit(expression: expression)
        }
    }
    
    @IBAction func pressAllClear(_ sender: Any) {
        lblExpression.text = ""
        lblResult.text = ""
    }
}

