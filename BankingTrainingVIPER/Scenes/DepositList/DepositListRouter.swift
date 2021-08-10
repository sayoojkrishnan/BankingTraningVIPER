//
//  DepositListRouter.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//
import UIKit

protocol AddDepositRouterDelegate : AnyObject  {
    func didAddNewDeposit(deposit : DepositViewModel)
}

final class DepositListRouter : DepositListRouterProtocol ,AddDepositRouterDelegate {
    
    weak var presenter: DepositListPresenterProtocol!
    var nav: UINavigationController!
    
    func navigateToDeposit() {
        let controller = AddDepositBuilder.build() as! AddDepositViewController
        controller.routerDelegate = self
        nav.pushViewController(controller, animated: true)
    }
    
    func didAddNewDeposit(deposit: DepositViewModel) {
        presenter.updateDeposit(deposit: deposit)
    }
    
}

