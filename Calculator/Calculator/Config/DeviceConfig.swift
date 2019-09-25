//
//  DeviceConfig.swift
//  Calculator
//
//  Created by Danish Aziz on 25/9/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

class DeviceConfig: NSObject {

    func isIPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    func isIPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
}
