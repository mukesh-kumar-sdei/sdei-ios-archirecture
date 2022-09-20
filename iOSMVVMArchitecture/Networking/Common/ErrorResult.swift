//
//  SErrors.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 14/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation

protocol OurErrorProtocol: LocalizedError, Codable {
    
    var title: String? { get }
    var code: Int { get }
}

struct NetworkError: OurErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
   
    init(with message:String) {
        self._description = message
        self.title = "Error"
        self.code = 401
    }
}

public enum ErrorResult: Error {
   
    case noError
    case networkError
    case jsonConversionFailure
    case invalidData
    case responseFailed
    case jsonParsingFailure
    case missingURL
    case encodingFailed
    case emailEmpty
    case emptyPassword
    case invalidEmail
    case invalidPassword
    case invalidPhone
   
    var localizedDescription: String {
        switch self {
        case .noError: return "No Error"
        case .networkError: return "Network Error"
        case .invalidData: return "Invalid Data"
        case .responseFailed: return "Error in Response"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .missingURL: return "ERROR: URL Missing"
        case .encodingFailed: return "Parameter Encoding Failed"
        case .emailEmpty: return "Please enter email"
        case .emptyPassword: return "Please enter password"
        case .invalidEmail: return "Please enter a valid email address"
        case .invalidPassword: return "Please enter a minimum 6 character password"
        case .invalidPhone: return "Please enter a valid phone number"
        }
    }
}
