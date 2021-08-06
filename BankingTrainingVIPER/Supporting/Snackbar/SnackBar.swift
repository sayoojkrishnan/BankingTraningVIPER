//
//  SnackBar.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 28/07/21.
//

import UIKit
final class SnackBar  :  NSObject {
    
    var dismissViewAfterHidden : Bool = true
    
    private enum SnackState {
        case hidden
        case visible
    }
    
    enum SnackBarType {
        case error
        case success
        case warning
        
        var colorScheme : ColorScheme {
            switch self {
            case .error:
                return ColorScheme(backgroundColor: .systemRed, labelColor: .white, actionButtonColor: .white, activityIndicatorColor: .white)
            case .success :
                return ColorScheme(backgroundColor: .systemGreen, labelColor: .white, actionButtonColor: .white, activityIndicatorColor: .white)
            case .warning :
                return ColorScheme(backgroundColor: .systemOrange, labelColor: .white, actionButtonColor: .white, activityIndicatorColor: .white)
            }
        }
    }
    
    
    struct ColorScheme {
        var backgroundColor : UIColor = .tertiarySystemBackground
        var labelColor : UIColor = .label
        var actionButtonColor : UIColor = .red
        var activityIndicatorColor : UIColor = .red
    }
    
    
    enum Duration : Double {
        case short = 2
        case medium = 5
        case long = 10
        case forEver = 2147483647
    }
    
    var colorScheme : ColorScheme! {
        didSet {
            alertView?.colorScheme = colorScheme
        }
    }
    
    private var alertView : AlertView?
    private var onWindow : UIView?
    private var leftAnchor : NSLayoutConstraint?
    private var rightAnchor : NSLayoutConstraint?
    private var widthAnchor : NSLayoutConstraint?
    
    var actionBlock :  actionButtonCallback?
    public typealias actionButtonCallback = ()->Void
    
    private override init() {
        super.init()
    }
    
    private var timer : Timer?
    
    var snackTitle : String = ""
    var snackDuration : Duration = Duration.medium
    var actionButtonTitle : String = ""
    
    
  
    

    public init(title : String , duration : Duration ,onView view: UIView? = nil){
        super.init()
        onWindow = view
        colorScheme = ColorScheme()
        snackTitle = title
        snackDuration = duration
        self.buildAlert()
        configure()
        
        alertView?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(panGesture:))))
    }
    
    public init(title : String , withActivityIndicator : Bool, onView view: UIView? = nil ){
        super.init()
        onWindow = view
        snackTitle = title
        snackDuration =  .forEver
        colorScheme = ColorScheme()
        self.buildAlert()
        configure(withActivityIndicator)
    }
    
    
    public init(title : String , actionButtonText : String,onView view: UIView? = nil, callback : @escaping actionButtonCallback ){
        super.init()
        onWindow = view
        snackTitle = title
        snackDuration = .forEver
        actionBlock = callback
        colorScheme = ColorScheme()
        actionButtonTitle = actionButtonText
        self.buildAlert()
        configure()
    }
    
    
    private func buildAlert() {
        alertView =  AlertView()
        alertView?.translatesAutoresizingMaskIntoConstraints = false
        alertView?.alpha = 0
    }
    
    
    deinit {
        print("SnackBar Removed from memory")
    }
    
}
extension SnackBar  {
    
    @objc private func onPanGesture(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .ended:
            let velocity = panGesture.velocity(in: alertView)
            if velocity.y < 0 {
                hide()
            }
        default :
            break
        }
        
    }
    
    
    private func configure( _ withActivityIndicator : Bool = false){
        if let window = onWindow ??  UIApplication.shared.windows.filter({return $0.isKeyWindow }).first {
            alertView!.title = snackTitle
            alertView!.colorScheme = colorScheme
            alertView!.showSpinner = withActivityIndicator
            alertView!.actionButtonTitle = actionButtonTitle
            alertView!.actionButtonCallback = {
                self.didClickActionButton()
            }
            
            window.addSubview(alertView!)
            
            leftAnchor = alertView!.leftAnchor.constraint(equalTo: window.layoutMarginsGuide.leftAnchor)
            rightAnchor = alertView!.rightAnchor.constraint(equalTo: window.layoutMarginsGuide.rightAnchor)
            widthAnchor = alertView!.widthAnchor.constraint(equalToConstant: 500)
            
            updateSizeAnchor(window: window)
            
            NSLayoutConstraint.activate([
                alertView!.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                alertView!.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
                alertView!.topAnchor.constraint(equalTo: window.layoutMarginsGuide.topAnchor , constant : 0),
            ])
        }
    }
    
    
    private func updateSizeAnchor(window : UIView){
        leftAnchor?.isActive = false
        rightAnchor?.isActive = false
        widthAnchor?.isActive = false
        
        if  window.traitCollection.horizontalSizeClass  == .compact {
            leftAnchor?.isActive = true
            rightAnchor?.isActive = true
        }else{
            widthAnchor?.isActive = true
        }
        
    }
    
    private func didClickActionButton(){
        if let action = actionBlock {
            action()
            hide()
        }
    }
    
    private func animate(toState state :  SnackState, then : @escaping ()->Void = {}){
        
        self.alertView?.transform = state == .hidden ? .identity : .init(translationX: 0, y: -100)
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView?.alpha =   state  == .hidden  ? 0 : 1
            self.alertView?.transform = state == .visible ? .identity : .init(translationX: 0, y: -100)
        }) { (doneAnimation) in
            then()
        }
    }
    
    private func dismiss(){
        timer?.invalidate()
        timer = nil
        if dismissViewAfterHidden {
            alertView?.removeFromSuperview()
            alertView = nil
        }
    }
    
    
    private func hapticFeedback(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    
}

extension SnackBar {
    
    public func show(){
        timer?.invalidate()
        timer = nil
        hapticFeedback()
        DispatchQueue.main.async { [weak self] in
            guard let this  = self else {return}
            this.animate(toState: .visible) {
                this.timer = Timer.scheduledTimer(timeInterval: this.snackDuration.rawValue, target: this, selector: #selector(this.hide), userInfo: nil, repeats: false)
            }
        }
    }
    
    @objc public func hide(){
        animate(toState: .hidden)  { [weak self] in
            self?.dismiss()
        }
    }
    
}
