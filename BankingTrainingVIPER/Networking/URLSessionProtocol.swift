//
//  URLSessionProtocol.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 19/07/21.
//

import Combine
import Foundation

protocol URLSessionProtocol {
    func dataTask(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError>
}

extension URLSession : URLSessionProtocol {
    func dataTask(for request: URLRequest) -> AnyPublisher<DataTaskPublisher.Output, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

