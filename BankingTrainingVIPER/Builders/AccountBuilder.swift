//
//  AccountBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 06/08/21.
//

import UIKit

struct AccountBuilder : BaseModuleBuilder {
    static func build() -> UIViewController {
        let account = Account()
        account.tabBarItem.title = "Account"
        account.tabBarItem.image = UIImage(systemName: "house")
        return account
    }
}
