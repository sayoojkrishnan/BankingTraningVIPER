//
//  Environment.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 19/07/21.
//

import Foundation



public enum Env {
    
    case mock
    case prod
    case qa
    case staging
    
    var url : String {
        switch self {
        case .prod:
            return "stirredverse.backendless.app"
        case .qa :
            return "stirredverse.backendless.app"
        case .staging:
            return "stirredverse.backendless.app"
        case .mock :
            return ""
        }
    }
    
}

protocol EnvBuildable  {
    var shouldMock : Bool {get}
    var env : Env {get}
}

class DepositsModule : EnvBuildable {
    

    private static var _instance : DepositsModule?
    
    static var instance : DepositsModule {
        guard let ins = _instance else {
            fatalError("Call the build method on DepositsEnv with proper env to initialize")
        }
        return ins
    }
    
    static func build(withEnv env : Env) -> DepositsModule {
        if _instance == nil {
            _instance = DepositsModule(env: env)
        }
        return _instance!
    }
    
    var env : Env {
        return _env
    }
    
    private let _env : Env
    private init(env : Env) {
        self._env = env
    }
    
    var shouldMock : Bool {
        return env == .mock
    }
    
    
}
