//
//  DepositListViewController+Animations.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import UIKit

extension DepositListViewController {
    
    func animateAndSetTotal(totalText : String) {
        if totalDepositAmount.text == totalText {return}
        self.totalDepositAmount.text = totalText
        totalDepositAmount.alpha = 0.4
        totalDepositAmount.transform = CGAffineTransform(translationX: 0, y: -60)
        UIView.animate(withDuration: 0.4) {
            self.totalDepositAmount.alpha = 1
            self.totalDepositAmount.transform = .identity
        }
    }
    
    
}
