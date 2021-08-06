//
//  MockURLSession.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 21/07/21.
//

import Foundation
import Combine

class MockURLSession : URLSessionProtocol {
    
    var nextError : Error?
    var nextData : Data = "{}".data(using: .utf8)!
    var nextResponse : HTTPURLResponse?
    
    func dataTask(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError> {
        if nextResponse == nil {
            nextResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        }
        return Just((data: nextData, response: nextResponse!))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
    
    
    
    
}
