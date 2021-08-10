//
//  DepositListPresenter.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//

import Foundation
typealias DepositListPresenterProtocolCombined = DepositListPresenterProtocol & DepositListInteractorPresenterProtocol
final class DepositListPresenter : DepositListPresenterProtocolCombined {
    
    

    func navigateToDeposit() {
        router.navigateToDeposit()
    }
    
    func present() {
        interactor.fetchDeposits()
    }
    
    func paginate() {
        interactor.paginate()
    }
    
    func updateDeposit(deposit: DepositViewModel) {
        interactor.updateDeposit(deposit: [deposit])
    }
    
    
    var view: DepositListViewControllerProtocol!
    
    var interactor: DepositListInteractorProtocol!
    
    var router: DepositListRouterProtocol!
    
}

extension DepositListPresenter  {
    
    func showWarning(message: String) {
        view.showWarning(message: message)
    }
    
    
    func updateBottomBanner(total: String, transactions: String) {
        view.updateBottomBanner(total: total, transactions: transactions)
    }
    
    func updateDeposit(deposits: [DepositViewModel]) {
        view.updateDeposit(deposits: deposits)
    }
    
    func updateSpinner(forState state: DepositListViewState) {
        view.updateSpinner(forState: state)
    }
    
    func updatePaginationUI(forState state: DepositListViewState) {
        view.updatePaginationUI(forState: state)
    }
    
}
