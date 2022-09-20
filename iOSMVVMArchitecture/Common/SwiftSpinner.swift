//
//  SwiftSpinner.swift
//  AccessEMRPOC
//
//  Created by Amit Shukla on 29/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation
import UIKit

class SwiftSpinner: UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .medium)
        ai.color = .white
        ai.startAnimating()
        ai.center = self.center
        self.addSubview(ai)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
