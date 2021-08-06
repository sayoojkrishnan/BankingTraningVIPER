//
//  BaseViewController.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    typealias AlertType = SnackBar.SnackBarType
    
    var snackBar : SnackBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showAlert(title :String , alertType :  AlertType? = nil) {
        hideAlert()
        snackBar = SnackBar(title: title, duration: .short)
        if let type = alertType {
            snackBar.colorScheme = type.colorScheme
        }
        snackBar.show()
    }
    
    
    func showAlert(title :String, actionButtonText : String ,alertType :  AlertType? = nil, callback : @escaping ()->Void) {
        hideAlert()
        snackBar = SnackBar(title: title, actionButtonText: actionButtonText, callback: callback)
        if let type = alertType {
            snackBar.colorScheme = type.colorScheme
        }
        snackBar.show()
    }
    
    
    
    func hideAlert() {
        if snackBar != nil {
            snackBar.hide()
            snackBar = nil
        }
    }
    
    
    
}
