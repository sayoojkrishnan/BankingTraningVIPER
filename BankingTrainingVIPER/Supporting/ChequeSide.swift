//
//  ChequeSide.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 20/07/21.
//

import Foundation
enum ChequeSide   {
    case front
    case back
    
    var description :String {
        switch  self {
        case .front:
            return "Front of cheque"
        case .back :
            return "Back of cheque"
        }
    }
    
    var scanInstruction : String {
        switch self {
        case .back :
            return #"Remember to Sign your cheque and below write "For Mobile Deposit at Santander Bank Only""#
        case .front :
            return "We'll take the photo or you can use the camera button"
        }
    }
}
