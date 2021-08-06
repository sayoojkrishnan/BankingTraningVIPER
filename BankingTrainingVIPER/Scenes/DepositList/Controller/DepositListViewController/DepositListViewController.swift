//
//  DepositListViewController.swift
//  DepositsFramework
//
//  Created by Sayooj Krishnan  on 16/07/21.
//

import UIKit
import Combine

class DepositListViewController: BaseViewController {
    
    class func build() -> DepositListViewController {
        return DepositListViewController(nibName: "DepositListViewController", bundle: Bundle(for: DepositListViewController.self))
    }
    
    private(set) lazy var searchController: UISearchController = {
        resultsTableController = SearchResultsController()
        let searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Deposit"
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = resultsTableController
        return searchController
    }()
    
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var totalTransactions: UILabel!
    
    @IBOutlet weak var totalDepositAmount: UILabel!
    
    private(set) var refreshController : UIRefreshControl!
    private(set) var dataSource =  DepositListTableViewDataSource()
    @IBOutlet weak var depositsTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    

    var presenter : DepositListPresenterProtocol?
    
    private(set) var resultsTableController: SearchResultsController!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Deposits"
        
        configureViews()
        presenter?.present()
        
        dataSource.reachedEndOfScroll = { [unowned self] in
            presenter?.paginate()
        }
    }

    func showFailureAlert(message :String) {
        showAlert(title: message, actionButtonText: "Retry",alertType: .error ) { [unowned self] in
            self.showAlert(title: message)
        }
    }
    
    
    private func buildNabutton() {
        let barbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapDeposit))
        navigationItem.rightBarButtonItem = barbutton
    }
    
    
    private func configureViews() {
        configureTableView()
        buildNabutton()
        spinner.startAnimating()
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 8
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        bottomView.isHidden = true
    }
    
    
    @objc private func didTapDeposit() {
        presenter?.navigateToDeposit()
    }
    
    
    private func configureRefreshControll() {
//        refreshController = UIRefreshControl(frame: CGRect.zero, primaryAction: UIAction(handler: { [unowned self ]action in
//
//        }))
//        depositsTableView.refreshControl = refreshController
    }

}
