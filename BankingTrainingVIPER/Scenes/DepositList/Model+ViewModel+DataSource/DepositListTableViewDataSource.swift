//
//  DepositListTableViewDataSource.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 22/07/21.
//

import UIKit

class DepositListTableViewDataSource : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var deposits : [DepositViewModel] = []
    
    var reachedEndOfScroll : (()->Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deposits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepositTableViewCell", for: indexPath) as! DepositTableViewCell
        let deposit = deposits[indexPath.row]
        cell.depositViewModel = deposit
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let last = deposits.count - 1
        if indexPath.row == last {
            reachedEndOfScroll?()
        }
    }
    
    func updateData(deposits : [DepositViewModel]?) {
        self.deposits = deposits ?? []
    }
}
