//
//  String.swift
//  AccessEMRPOC
//
//  Created by Amit Shukla on 28/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
