//
//  AddDepositBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 09/08/21.
//

import UIKit

struct AddDepositBuilder : BaseModuleBuilder {
    static func build() -> UIViewController {
        
        let controller = AddDepositViewController(nibName: "AddDepositViewController", bundle: Bundle(for: AddDepositViewController.self))
        
        let presenter = AddDepositPresenter()
        let router = AddDepositRouter()
        let interactor = AddDepositInteractor()
        
        presenter.interactor  = interactor
        presenter.router = router
        presenter.view = controller
        controller.presenter = presenter
        
        interactor.presenter = presenter
        return controller
        
    }
}
