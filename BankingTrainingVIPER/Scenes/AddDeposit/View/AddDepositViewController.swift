//
//  AddDepositViewController.swift
//  BankingTrainingVIPER
//
//  Created by Biswajit Palei on 09/08/21.
//

import Foundation
import UIKit

protocol AddDepositViewControllerResponseDelegate : AnyObject {
    func didDepositCheque(deposit : DepositModel)
}

class AddDepositViewController:BaseViewController {
    
    weak var routerDelegate : AddDepositRouterDelegate?
    @IBOutlet weak var loadingBar: UIStackView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var chequeBackImage: ChequImageView!
    @IBOutlet weak var chequeFrontImage: ChequImageView!
    @IBOutlet weak var chequeDescription : UITextField!
    @IBOutlet weak var date: UIDatePicker!
    
    var presenter: AddDepositPresenterProtocol?
    var delegate:AddDepositViewControllerResponseDelegate?
    var router: AddDepositRouterProtocol?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        loadingBar.isHidden = true
        buildNabutton()
        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapSave)))
        
    }
    private func buildNabutton() {
        let barbutton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem = barbutton
    }
    
    @objc private func didTapSave() {
        self.view.endEditing(true)
        loadingBar.isHidden = false
        spinner.startAnimating()
        self.presenter?.AddDeposit(date: date.date, chequeAmount:amount.text!, description: chequeDescription.text!)
    }
    
    func showFailureAlert(message :String) {
        showAlert(title: message, actionButtonText: "Retry",alertType: .error ) { [unowned self] in
            self.showAlert(title: message)
        }
    }
}
extension AddDepositViewController:AddDepositViewControllerProtocol{
    func updateSpinner(forState state: DepositListViewState) {
        switch state {
        case .loading :
            spinner.startAnimating()
        case .failed(let error) :
            spinner.stopAnimating()
            showFailureAlert(message: error)
        case .success :
            spinner.stopAnimating()
            loadingBar.isHidden = true
        }
    }
    
    func showWarning(message: String) {
      showFailureAlert(message: message)
    }
    
    func ReceiveData(_ data:DepositViewModel){
        routerDelegate?.didAddNewDeposit(deposit: data)
        router?.navigateBackToListViewController(from: self)
    }
}
