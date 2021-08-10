//
//  AddDepositInteractor.swift
//  BankingTrainingVIPER
//
//  Created by Biswajit Palei on 09/08/21.
//

import Foundation
import Combine
import UIKit.UIImage

class AddDepositInteractor:AddDepositInteractorInputProtocol, AddDepositInteractorOutputProtocol {
    enum ViewState {
        
        case depositing
        case deposited(DepositModel)
        case failed(String)
        case initial
        
        var hasFailed : Bool {
            switch self {
            case .failed(_):
                return true
            default:
                return false
            }
        }
    }
    
    private(set) var state =  CurrentValueSubject<ViewState,Never>(.initial)
    
    var presenter: AddDepositPresenter?
    var deposits: DepositViewModel?
    let addDepositService:DepositChequeServiceProtocol
    var depositCancellable : AnyCancellable?
    
    init(service : DepositChequeServiceProtocol = AddDepositService()) {
        self.addDepositService = service
    }
    
    func addDeposit(date: Date, chequeAmount: String, description: String) {
        self.deposit(amount: chequeAmount, description: description, date: date)
    }
    
    func didAdd(_ add: DepositViewModel) {
        // INTERACTOR -> PRESENTER
        
    }
    
    func deposit(amount:String, description:String, date:Date){
        guard let amount = Double(amount),!description.isEmpty  else {
            state.value = .failed("Fill in all required fields")
            return
        }
        
        let depositDate = date.timeIntervalSince1970
        
        let params : [String:Any] = [
            "depositAmount" : amount,
            "depositDate": depositDate * 1000 ,
            "created" : Date().timeIntervalSince1970 * 1000,
            "depositDescription" : description
        ]
        
        state.value = .depositing
        depositCancellable =  addDepositService.depositCheuqe(param: params)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] response in
                switch response {
                case .finished :
                    break
                case .failure(let error) :
                    self?.state.value = .failed(error.desciprtion)
                }
            }, receiveValue: {[weak self] model in
                self?.state.value = .deposited(model)
                self?.presenter?.didAdd(DepositViewModel(deposit: model))
            })
    }
    
}
