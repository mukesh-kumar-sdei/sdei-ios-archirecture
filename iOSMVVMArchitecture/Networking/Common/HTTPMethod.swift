//
//  HTTPMethods.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 16/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = Dictionary<String, String>

public enum HTTPMethod : String {
    
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    
    public var name:String {
        return self.rawValue
    }
}

