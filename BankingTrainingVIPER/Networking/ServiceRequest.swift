//
//  ServiceRequest.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 19/07/21.
//

import Foundation


protocol ServiceRequest  {
    var path : String {get}
    var params : [String:String] {get}
    var method : ServiceRequestMethod {get}
    var body : Data? {get}
    var host : String {get}
}

extension ServiceRequest {
    
    var host : String {
        return DepositsModule.instance.env.url
    }
    
    var endPoint : URL {
        let host = host
        var components = URLComponents()
        components.queryItems = params.map({ return URLQueryItem(name: $0, value: $1)})
        components.path = path
        components.scheme = "https"
        components.host = host
        components.port = 443
        return components.url!
    }
}

