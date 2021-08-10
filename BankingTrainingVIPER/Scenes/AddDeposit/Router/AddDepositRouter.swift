//
//  AddDepositRouter.swift
//  BankingTrainingVIPER
//
//  Created by Biswajit Palei on 09/08/21.
//

import Foundation
import UIKit

class AddDepositRouter:AddDepositRouterProtocol{
    static func AddDepositRouterModule(with todo: DepositModel) -> UIViewController {
        return UIViewController()
    }
    
    func navigateBackToListViewController(from view: AddDepositViewControllerProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
}
