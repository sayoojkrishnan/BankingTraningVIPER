//
//  AddDepositService.swift
//  BankingTrainingVIPER
//
//  Created by Biswajit Palei on 09/08/21.
//

import Foundation
import Combine

protocol DepositChequeServiceProtocol  : MockNeworkServiceBuildable {
    func depositCheuqe(param : [String:Any]) -> AnyPublisher<DepositModel,DepositError>
}

protocol ScanChequeResponseDelegate : AnyObject {
    func didDepositCheque(deposit : DepositModel)
}

final class AddDepositService : DepositChequeServiceProtocol {
    
    
    var mockType: MockType?
    
    func depositCheuqe(param: [String : Any]) -> AnyPublisher<DepositModel, DepositError> {
        
        let service = DepositChequeRequest(params: param)
        mockType = .mockData(buildDummyResponseData(param: param))
        
        let client = client
        
        return client.request(type: DepositModel.self, serviceRequest: service)
            .mapError({
                switch $0 {
                case .failedToConnectToHost :
                    return .noInternet
                default :
                    return DepositError.failedToDeposit
                }
            })
            .eraseToAnyPublisher()
        
    }
    
    
    private func buildDummyResponseData(param : [String:Any]) -> Data{
        
        let newResponse = DepositModel(
            id: UUID().uuidString,
            date: param["depositDate"] as? Double,
            chequeAmount: param["depositAmount"]  as? Double,
            description: param["depositDescription"]  as? String,
            checkFrontImage: nil,
            checkBackImage: nil
        )
        
        return try! JSONEncoder().encode(newResponse)
    }
    
}

struct DepositChequeRequest  : ServiceRequest {
    
    var path: String = "/api/data/Deposits"
    var params: [String : String] = [:]
    var method: ServiceRequestMethod = .POST
    var body: Data?
    
    init(params : [String:Any]) {
        body = try? JSONSerialization.data(withJSONObject: params)
    }
}
