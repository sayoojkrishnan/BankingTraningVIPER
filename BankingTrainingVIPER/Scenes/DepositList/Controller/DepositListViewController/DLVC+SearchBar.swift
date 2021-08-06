//
//  DepositListViewController+SearchBar.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import UIKit

// MARK: - UISearchBarDelegate

extension DepositListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        resultsTableController.deposits = dataSource.deposits
    }
}
