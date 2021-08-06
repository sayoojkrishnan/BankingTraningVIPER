//
//  DepositListViewController+UIBindings.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import UIKit
import Combine
extension DepositListViewController : DepositListViewControllerProtocol {
    
    func updateBottomBanner(total: String, transactions: String) {
        totalTransactions.text = transactions
        animateAndSetTotal(totalText: total)
    }
    
    func updateSpinner(forState state : DepositListViewState) {
        switch state {
        case .loading :
            spinner.startAnimating()
        case .failed(let error) :
            spinner.stopAnimating()
            showFailureAlert(message: error)
        case .success :
            depositsTableView.isHidden = false
            spinner.stopAnimating()
        }
    }
    
    func updatePaginationUI(forState state: DepositListViewState) {
        let frame = CGRect(x: 0, y: 0, width: depositsTableView.frame.width, height: 50)
        switch state {
        case .failed(let error) :
            depositsTableView.tableFooterView = PaginationHelper.failedView(frame: frame, error: error)
        case .success :
            depositsTableView.tableFooterView = nil
        case .loading :
            depositsTableView.tableFooterView = PaginationHelper.spinner(frame: frame)
        }
    }
    
    func updateDeposit(deposits: [DepositViewModel]) {
        dataSource.deposits = deposits 
        depositsTableView.reloadData()
    }
    
}



struct PaginationHelper {
    
    static func spinner(frame : CGRect) -> UIActivityIndicatorView {
        let activity = UIActivityIndicatorView(frame: frame)
        activity.startAnimating()
        activity.color = .gray
        return activity
    }
    
    static func failedView(frame : CGRect, error :String) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = error
        return label
    }
    
}
