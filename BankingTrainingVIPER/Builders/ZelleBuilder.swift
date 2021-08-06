//
//  ZelleBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 06/08/21.
//

import UIKit

struct ZelleBuilder : BaseModuleBuilder {
    static func build() -> UIViewController {
        // set presnter , interactor, router here
        let zelle = Zelle()
        zelle.tabBarItem.title = "Zelle"
        zelle.tabBarItem.image = UIImage(systemName: "dollarsign.circle")
        return zelle
    }
}

