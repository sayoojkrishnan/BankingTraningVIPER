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

class AddDepositViewController:BaseViewController{
    
    class func build() -> AddDepositViewController {
        return AddDepositViewController(nibName: "AddDepositViewController", bundle: Bundle(for: AddDepositViewController.self))
    }
    
    @IBOutlet weak var loadingBar: UIStackView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var chequeBackImage: ChequImageView!
    @IBOutlet weak var chequeFrontImage: ChequImageView!
    @IBOutlet weak var chequeDescription : UITextField!
    @IBOutlet weak var date: UIDatePicker!
    
    var presenter: AddDepositPresenterProtocol?
    var delegate:AddDepositViewControllerResponseDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildNabutton()
        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapSave)))
        
    }
    private func buildNabutton() {
        let barbutton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem = barbutton
    }
    
    @objc private func didTapSave() {
        self.view.endEditing(true)
    }
}
extension AddDepositViewController:AddDepositViewControllerProtocol{
    func updateSpinner(forState state: DepositListViewState) {
        
    }
    
    func showWarning(message: String) {
        
    }
}