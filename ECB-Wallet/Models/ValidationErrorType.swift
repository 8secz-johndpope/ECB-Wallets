//
//  ValidationErrorType.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation
import Validator

struct ExampleValidationError: ValidationError {

    let message: String
    
    public init(_ message: String) {
        
        self.message = message
    }
}
