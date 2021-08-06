//
//  NetworkClientError.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 19/07/21.
//

import Foundation

enum NetworkClientError : Error {
    case failedToConnectToHost
    case notFound
    case invalidURL
    case failedToParse
    case serverError
}
