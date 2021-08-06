//
//  DepositListProtocols.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//

import Foundation

enum DepositListViewState {
    case loading
    case failed(String)
    case success
}

protocol DepositListViewControllerProtocol : AnyObject {
    
    func updateDeposit(deposits : [DepositViewModel])
    
    func updateSpinner(forState state: DepositListViewState)
    
    func updatePaginationUI(forState state: DepositListViewState)
    
    func updateBottomBanner(total :String, transactions : String)
    
}

protocol DepositListRouterProtocol : AnyObject {
    func navigateToDeposit()
}

protocol DepositListPresenterProtocol  : AnyObject {
    
    var view : DepositListViewControllerProtocol! {get set}
    var interactor : DepositListInteractorProtocol! {get set}
    var router : DepositListRouterProtocol! {get set}
    
    func navigateToDeposit()
    func present()
    
   
}


typealias DepositListInteractorPresenterProtocol = DepositListViewControllerProtocol
protocol DepositListInteractorProtocol : AnyObject {
    init(service : DepositsListServiceProtocol)
    func fetchDeposits()
    var presenter : DepositListInteractorPresenterProtocol! {get set}
}

