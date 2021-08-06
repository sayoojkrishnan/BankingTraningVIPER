//
//  DepositBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//

import UIKit

struct DepositBuilder : BaseModuleBuilder {
    static func build() -> UIViewController {
        let interactor = DepositListInteractor()
        let presenter = DepositListPresenter()
        let router = DepositListRouter()
        let controller = DepositListViewController.build()
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = controller
        interactor.presenter = presenter
        
        controller.tabBarItem.title = "Deposit"
        controller.tabBarItem.image = UIImage(systemName: "square.and.arrow.down.on.square")
        return controller
    }
}
