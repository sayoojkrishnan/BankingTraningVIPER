//
//  DepositListProtocols.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//

import UIKit

enum DepositListViewState  : Equatable{
    case loading
    case failed(String)
    case success
}

protocol DepositListViewControllerProtocol : AnyObject {
    
    func updateDeposit(deposits : [DepositViewModel])
    
    func updateSpinner(forState state: DepositListViewState)
    
    func updatePaginationUI(forState state: DepositListViewState)
    
    func updateBottomBanner(total :String, transactions : String)
    
    func showWarning(message : String)
    
}

protocol DepositListRouterProtocol : AnyObject {
    var nav : UINavigationController! {get}
    func navigateToDeposit()
}

protocol DepositListPresenterProtocol  : AnyObject {
    
    var view : DepositListViewControllerProtocol! {get set}
    var interactor : DepositListInteractorProtocol! {get set}
    var router : DepositListRouterProtocol! {get set}
    
    func navigateToDeposit()
    func present()
    func paginate()
   
}


typealias DepositListInteractorPresenterProtocol = DepositListViewControllerProtocol
protocol DepositListInteractorProtocol : AnyObject {
    init(service : DepositsListServiceProtocol)
    func fetchDeposits()
    func paginate() 
    var presenter : DepositListInteractorPresenterProtocol! {get set}
}

