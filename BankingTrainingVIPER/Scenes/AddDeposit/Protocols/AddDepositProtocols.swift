//
//  AddDepositProtocols.swift
//  BankingTrainingVIPER
//
//  Created by Biswajit Palei on 09/08/21.
//

import Foundation
import UIKit

protocol AddDepositPresenterProtocol: AnyObject {
    
    var view: AddDepositViewControllerProtocol? { get set }
    var interactor: AddDepositInteractorInputProtocol? { get set }
    var router: AddDepositRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func AddDeposit(date: String, chequeAmount: Double, description:String)
}

protocol AddDepositInteractorInputProtocol: AnyObject {
    
    var presenter: AddDepositInteractorInputProtocol? { get set }
    var deposits: DepositViewModel? { get set }
    
    // PRESENTER -> INTERACTOR
    func addDeposit(date: Date, chequeAmount: String, description:String)
}

protocol AddDepositInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didAdd(_ add: DepositViewModel)
}

protocol AddDepositViewControllerProtocol : AnyObject {
    
    var presenter: AddDepositPresenterProtocol? { get set }
    
    func updateSpinner(forState state: DepositListViewState)
        
    func showWarning(message : String)
    
    // PRESENTER -> VIEW
}
protocol AddDepositRouterProtocol: AnyObject {
    
    static func AddDepositRouterModule(with todo: DepositModel) -> UIViewController

    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: AddDepositViewControllerProtocol)
    
}
