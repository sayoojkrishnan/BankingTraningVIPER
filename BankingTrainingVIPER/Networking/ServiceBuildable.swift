//
//  ServiceBuildable.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 21/07/21.
//

import Foundation

enum MockType {
    case localJSON(String)
    case mockData(Data)
}

protocol MockNeworkServiceBuildable {
    var mockType : MockType? {get set}
    var client : NetworkClient {get}
    var env : EnvBuildable {get}
}

extension MockNeworkServiceBuildable {
    
    var env : EnvBuildable {
        DepositsModule.instance
    }
    
    
    var client : NetworkClient {
        if env.shouldMock {
            print("Env set to MOCK, will check for local json or mock response data")
            ///Env set to MOCK, will check for local json or mock response data
            if let mockType = mockType {
                switch mockType {
                case .localJSON(let json):
                    return buildClient(with: json)
                case .mockData(let data) :
                    return buildClient(with: data)
                }
            }
            fatalError("Mock env detected. Should specifiy either 'localJSONFile' or 'responseData'")
        }
        
        return NetworkClient()
        
    }
    
    
    func buildClient(with responseData : Data) ->NetworkClient {
        let session = MockURLSession()
        session.nextData = responseData
        return NetworkClient(session: session)
    }
    
    
    func buildClient(with localJSONFile : String) -> NetworkClient{
        
        guard let  bundleId = Helper.bundleID else {
            fatalError("Failed to read bundleId")
        }
        
        guard let bundle = Bundle(identifier: bundleId) else {
            fatalError("Bundle not found!")
        }
        
        guard let path = bundle.url(forResource: localJSONFile, withExtension: "json") else {
            fatalError("Could not read the \(localJSONFile)")
        }
        
        let jsonString = try? String(contentsOf: path)
        
        guard let jsonData = jsonString?.data(using: .utf8) else {
            fatalError("Could not prepare date from \(path) file")
        }
        
        let session = MockURLSession()
        session.nextData = jsonData
        return NetworkClient(session: session)
        
    }
    
}



class Helper {
    
    static var bundleID : String? {
        let bundle = Bundle(for: self)
        return bundle.bundleIdentifier
    }
}
