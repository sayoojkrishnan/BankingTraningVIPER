//
//  HomeTabBarBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 06/08/21.
//

import UIKit
struct HomeTabBarBuilder :  BaseModuleBuilder {
    
    private static func getViewControllers() -> [UIViewController] {
        return [
            ZelleBuilder.build(),
            AccountBuilder.build(),
            DepositBuilder.build(),
            TransferBuilder.build(),
            MoreBuilder.build()
        ]
            
    }
    
    static func build() -> UIViewController {
        let tab = HomeTabBarController()
        tab.childrenViewControllers = Self.getViewControllers()
        return tab
    }
    
}
