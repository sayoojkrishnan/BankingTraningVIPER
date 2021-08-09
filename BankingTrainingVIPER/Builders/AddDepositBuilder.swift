//
//  AddDepositBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 09/08/21.
//

import UIKit

struct AddDepositBuilder : BaseModuleBuilder {
    static func build() -> UIViewController {
        return AddDepositViewController(nibName: "AddDepositViewController", bundle: Bundle(for: AddDepositViewController.self))
    }
}
