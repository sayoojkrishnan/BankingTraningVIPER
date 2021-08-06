//
//  DepositError.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//

import Foundation
enum DepositError : Error {
    
    case failedToLoad
    case noInternet
    case failedToDeposit
    
    var desciprtion : String {
        switch self {
        case .failedToLoad:
            return "Failed to retrive the deposits"
        case .noInternet :
            return "Internet connection appears to be offline!"
        case .failedToDeposit :
            return "Failed to deposit cheque"
        }
    }
    
}
