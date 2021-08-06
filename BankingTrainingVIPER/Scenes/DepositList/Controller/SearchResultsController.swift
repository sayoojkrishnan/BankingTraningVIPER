//
//  searchResultsController.swift
//  Deposits
//
//  Created by Biswajit Palei on 27/07/21.
//

import UIKit
import Combine

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    
    var deposits : [DepositViewModel]?
    private var searchResult : [DepositViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepositTableViewCell", for: indexPath) as! DepositTableViewCell
        cell.depositViewModel = searchResult[indexPath.row]
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text ?? ""
        self.searchResult = self.deposits?.filter({$0.search(keyword: keyword)}) ?? []
        self.tableView.reloadData()
    }
    
}

//UITableViewDataSource , UITableViewDelegate
extension SearchResultsController  {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let depositNib = UINib(nibName: "DepositTableViewCell", bundle: Bundle(for: DepositTableViewCell.self))
        tableView.register(depositNib, forCellReuseIdentifier: "DepositTableViewCell")
    }
}
