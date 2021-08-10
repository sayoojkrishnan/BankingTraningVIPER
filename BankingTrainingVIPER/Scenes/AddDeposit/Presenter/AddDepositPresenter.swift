//
//  AddDepositPresenter.swift
//  BankingTrainingVIPER
//
//  Created by Biswajit Palei on 09/08/21.
//

import Foundation
import UIKit.UIViewController

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
extension AddDepositPresenter: AddDepositViewControllerProtocol{
    
    func updateSpinner(forState state: DepositListViewState) {
        view?.updateSpinner(forState: state)
    }
    
    func showWarning(message: String) {
        view?.showWarning(message: message)
    }
    
    func ReceiveData(_ data: DepositViewModel) {
        
    }
}
