//
//  BaseViewModel.swift
//  AccessEMRPOC
//
//  Created by Amit Shukla on 28/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {

    var error: ErrorResult? {
        didSet { self.onError?(error!) }
    }
    var isLoading: Bool = false {
        didSet { self.onLoading?() }
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var onError : ((ErrorResult) -> Void)?
    var onLoading: (() -> ())?
}
