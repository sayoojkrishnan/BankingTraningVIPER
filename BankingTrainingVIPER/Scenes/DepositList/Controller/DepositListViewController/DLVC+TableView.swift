//
//  DepositListViewController+TableView.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import UIKit

//UITableViewDataSource , UITableViewDelegate
extension DepositListViewController  {
    
    func configureTableView() {
        
        self.navigationItem.searchController = searchController
        
        depositsTableView.delegate = dataSource
        depositsTableView.dataSource = dataSource
        depositsTableView.isHidden = true
        
        let depositNib = UINib(nibName: "DepositTableViewCell", bundle: Bundle(for: DepositTableViewCell.self))
        depositsTableView.register(depositNib, forCellReuseIdentifier: "DepositTableViewCell")
      
    }
}
