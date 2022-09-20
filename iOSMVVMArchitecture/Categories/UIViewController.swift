//
//  UIViewController.swift
//  AccessEMRPOC
//
//  Created by Amit Shukla on 03/02/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func instantiate<T: UIViewController>(appStoryboard: Storyboard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
