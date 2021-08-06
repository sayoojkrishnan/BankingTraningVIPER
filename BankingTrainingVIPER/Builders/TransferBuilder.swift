//
//  TransferBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 06/08/21.
//

import UIKit



struct TransferBuilder : BaseModuleBuilder {
    static func build() -> UIViewController {
        let transfer = Transfer()
        transfer.tabBarItem.title = "Tranfer"
        transfer.tabBarItem.image = UIImage(systemName: "arrowshape.bounce.forward")
        return transfer
    }
}

