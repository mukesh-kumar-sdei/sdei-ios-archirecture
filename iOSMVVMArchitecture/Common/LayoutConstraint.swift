//
//  LayoutConstraint.swift
//  HealthKitSample
//
//  Created by Surjeet Singh on 9/22/17.
//  Copyright © 2017 Surjeet Singh. All rights reserved.
//

import UIKit

@IBDesignable
class LayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable
    var iPhoneX: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY >= 812 {
                constant = iPhoneX
            }
        }
    }
}
