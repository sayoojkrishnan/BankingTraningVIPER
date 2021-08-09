//
//  AddDepositPresenter.swift
//  BankingTrainingVIPER
//
//  Created by Biswajit Palei on 09/08/21.
//

import Foundation

class AddDepositPresenter: AddDepositPresenterProtocol {

    weak var view: AddDepositViewControllerProtocol?
    var router: AddDepositRouterProtocol?
    var interactor: AddDepositInteractorInputProtocol?
    
    
    func viewDidLoad() {

    }
    
    func AddDeposit(date: String, chequeAmount: Double, description: String) {

    }
}

extension AddDepositPresenter: AddDepositInteractorOutputProtocol {
    func didAdd(_ add: DepositViewModel) {
        
    }
}
