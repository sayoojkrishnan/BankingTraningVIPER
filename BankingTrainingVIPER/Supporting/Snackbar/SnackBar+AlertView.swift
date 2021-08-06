//
//  SnackBar+AlertView.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import UIKit

extension SnackBar {
    
    class AlertView : UIView {
        
        var colorScheme : SnackBar.ColorScheme! {
            didSet {
                containerView.backgroundColor = colorScheme.backgroundColor
                titleLabel.textColor = colorScheme.labelColor
                activityIndicator.color = colorScheme.activityIndicatorColor
                actionButton.setTitleColor(colorScheme.actionButtonColor, for: .normal)
            }
        }
        
        var title : String? {
            didSet {
                titleLabel.text = title
            }
        }
        var actionButtonCallback : (() ->())?
        var actionButtonTitle : String?{
            didSet {
                if  actionButtonTitle != "" {
                    titleLabel.textAlignment = .left
                    actionButton.setTitle(actionButtonTitle!, for: .normal)
                    actionButton.sizeToFit()
                    containerStack.addArrangedSubview(actionButton)
                }
            }
        }
        
        var showSpinner : Bool?{
            didSet {
                if showSpinner! {
                    titleLabel.textAlignment = .left
                    containerStack.addArrangedSubview(activityIndicator)
                    activityIndicator.startAnimating()
                }
            }
        }
        
        
        private let titleLabel : UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.textColor = .systemTeal
            return label
        }()
        
        private let containerView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds  = true
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            return view
        }()
        
        private lazy var containerStack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [titleLabel])
            stack.axis = .horizontal
            stack.distribution = .equalCentering
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
            
        }()
        
        let actionButton : UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(didClickActionButton), for: .touchUpInside)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            button.setTitleColor(.black, for: .normal)
            return button
        }()
        
        private let activityIndicator : UIActivityIndicatorView = {
            let activity  =  UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            activity.hidesWhenStopped = true
            activity.color = .gray
            return activity
        }()
        
        deinit {
            print("AlertView Removed from memory")
        }
        
        
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            addSubview(containerView)
            containerView.addSubview(containerStack)
            
            NSLayoutConstraint.activate([
                containerView.leftAnchor.constraint(equalTo: leftAnchor),
                containerView.rightAnchor.constraint(equalTo: rightAnchor),
                containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                containerView.topAnchor.constraint(equalTo: topAnchor),
                
                
                containerStack.leftAnchor.constraint(equalTo: containerView.leftAnchor , constant : 10),
                containerStack.rightAnchor.constraint(equalTo: containerView.rightAnchor , constant : -10),
                containerStack.topAnchor.constraint(equalTo: containerView.topAnchor ,constant : 8),
                containerStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor , constant : -8)
            ])
        }
        
        
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            guard traitCollection.userInterfaceStyle == .light else {return}
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.4
            self.layer.shadowOffset = CGSize(width: 1, height: 2)
            self.layer.shadowRadius = 3
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
        
        
        private func handleTraitChange(){
            if UIScreen.main.traitCollection.horizontalSizeClass == .regular &&  UIScreen.main.traitCollection.verticalSizeClass == .regular {
                titleLabel.font = UIFont.systemFont(ofSize: 21)
                actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            }else{
                titleLabel.font = UIFont.systemFont(ofSize: 19)
                actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            }
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            handleTraitChange()
        }
        
        
        @objc private func didClickActionButton(){
            actionButtonCallback?()
        }
    }
    
}
