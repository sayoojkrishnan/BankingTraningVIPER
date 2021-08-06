//
//  ViewController.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    var childrenViewControllers : [UIViewController]! {
        didSet {
            viewControllers = childrenViewControllers ?? []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}



class Zelle : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}

class Transfer : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}

class Account : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}

class More : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

