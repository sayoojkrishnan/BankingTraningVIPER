//
//  DepositsService.swift
//  Deposits
//
//  Created by Swathi on 14/07/21.
//

import Foundation
import Combine


protocol DepositsListServiceProtocol : MockNeworkServiceBuildable  {
    func fetchDeposits(pageSize : Int, offset : Int) ->AnyPublisher<[DepositModel],DepositError>
}

final class DepositListsService : DepositsListServiceProtocol {
    
    var mockType: MockType? = .localJSON("deposits_list")
    
    func fetchDeposits(pageSize : Int, offset : Int) -> AnyPublisher<[DepositModel], DepositError> {
        
        let request = DepositListRequest(params: [
            "pageSize" : pageSize.description,
            "offset" : offset.description
        ])
        
        let client = client
        return client
            .request(type: [DepositModel].self, serviceRequest: request)
            .mapError({ error in
                switch error {
                case .failedToConnectToHost :
                    return .noInternet
                default :
                    return DepositError.failedToLoad
                }
            })
            .eraseToAnyPublisher()
    }
    
}



struct DepositListRequest : ServiceRequest {
    
    var path: String = "/api/data/Deposits"
    var params: [String : String]
    var method: ServiceRequestMethod = .GET
    var body: Data? = nil
    
}
