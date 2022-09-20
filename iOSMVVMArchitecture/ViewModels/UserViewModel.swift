//
//  UserViewModel.swift
//  AccessEMRPOC
//
//  Created by Amit Shukla on 28/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation

class UserViewModel: BaseViewModel {
    
    // MARK: - Parameters
    private(set) var service:UserService
    private(set) var user:User? {
        didSet { self.onLoginSuccess?() }
    }
    
    // MARK: - Closures
    var onLoginSuccess: (() -> ())?
    
    // MARK: - Constructor
    init(with service:UserService) {
        self.service = service
    }
    
    // MARK: Validation Methods
    
    func isValid(email: String?, password: String?) -> (isValid: Bool, error: ErrorResult?) {
        
        guard let email = email, !email.isEmpty else {
            return (false, .emailEmpty)
        }
        guard Validator.email(email).validate else {
            return (false, .invalidEmail)
        }
        
        guard let pswd = password, !pswd.isEmpty else {
            return (false, .emptyPassword)
        }
        
        guard pswd.count >= 6 else {
            return (false, .invalidPassword)
        }
        return (true, nil)
    }
    
    // MARK: - Network calls
    func login(with email: String?, password: String?) {
        
        let validationTuple = isValid(email: email, password: password)
        guard validationTuple.isValid else {
            self.error = validationTuple.error
            return
        }
        
        self.isLoading = true
        let params = [Key.Params.email:email!, Key.Params.password:password!]
        service.doLogin(with: params) { (result) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .Success(let data):
                    self.user = data
                case .Error(let error):
                    debugPrint("error = \(error.localizedDescription)")
                    self.error = error
                }
            }
        }
    }
}

