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
    
    
    func viewDidLoad() {}
    
    func AddDeposit(date: Date, chequeAmount: String, description: String) {
        interactor?.addDeposit(date: date, chequeAmount: chequeAmount, description: description)
    }
}

extension AddDepositPresenter: AddDepositInteractorOutputProtocol {
    func didAdd(_ add: DepositViewModel) {
      print(add)
      view?.ReceiveData(add)
    }
}
