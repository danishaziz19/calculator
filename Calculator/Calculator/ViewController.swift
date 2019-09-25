//
//  ViewController.swift
//  Calculator
//
//  Created by Danish Aziz on 25/9/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation)
    }

}

