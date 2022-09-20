//
//  User.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 23/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import UIKit

class User:Codable {
    
    var name: String?
    var email:String?

    enum CodingKeys: String, CodingKey {
       case name
       case email
    }

    init(name: String?, email: String) {
       self.name = name
       self.email = email
    }
}
