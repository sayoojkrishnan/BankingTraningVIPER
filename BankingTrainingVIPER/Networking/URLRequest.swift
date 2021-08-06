//
//  URLRequest.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 19/07/21.
//

import Foundation

extension URLRequest {
    init(serviceRequest : ServiceRequest) {
        self.init(url: serviceRequest.endPoint)
    
        httpMethod = serviceRequest.method.rawValue
        httpBody = serviceRequest.body
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        setValue("application/json", forHTTPHeaderField: "Accept")
    }
}


