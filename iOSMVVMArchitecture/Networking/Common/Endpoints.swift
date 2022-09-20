//
//  APIEndPoints.swift
//  AccessEMRPOC
//
//  Created by Amit Shukla on 29/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation

protocol EndpointType {
    
    var baseURL: URL { get }
    var path: String { get }
}

public enum Endpoints {
    case user(_ name: String)
    case contacts(_ name: String)
}

extension Endpoints: EndpointType {
    
    var baseURL: URL {
        return URL(string: "https://user.textmymainnumber.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .user(let name):
            return "/user/\(name)"
        case .contacts(let name):
            return "/contacts/\(name)"
        }
    }
}


