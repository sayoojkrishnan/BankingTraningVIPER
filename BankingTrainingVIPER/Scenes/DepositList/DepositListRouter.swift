//
//  DepositListRouter.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//

import UIKit
final class DepositListRouter : DepositListRouterProtocol {
    
    var nav: UINavigationController!
    func navigateToDeposit() {
        
        let controlelr = AddDepositBuilder.build()
        nav.pushViewController(controlelr, animated: true)
    }
    
    
}

