//
//  ChequImageView.swift
//  Deposits
//
//  Created by Sayooj Krishnan  on 18/07/21.
//

import UIKit

protocol ChequImageViewDelegate : AnyObject {
    func didRequestToOpenCamera(for chequeSide: ChequeSide)
}

class ChequImageView : UIView {
    
    
    var chequeSide : ChequeSide? {
        didSet {
            chequePostionLabel.text = chequeSide?.description
        }
    }
    
    private var dummyImage  : UIImage {
        let sizeConf = UIImage.SymbolConfiguration(pointSize: 340)
        return UIImage(systemName: "camera",withConfiguration: sizeConf)!
    }
    
    var chequeImage : UIImage? {
        didSet {
            updateImage()
        }
    }
    
    weak var delegate : ChequImageViewDelegate?
    
    let chequeImageView : UIImageView = {
        let chequeImageView =  UIImageView()
        chequeImageView.translatesAutoresizingMaskIntoConstraints = false
        chequeImageView.contentMode = .scaleAspectFit
        chequeImageView.tintColor = .systemGray3
        return chequeImageView
    }()
    
    let chequePostionLabel : UILabel = {
        let chequePostionLabel = UILabel()
        chequePostionLabel.translatesAutoresizingMaskIntoConstraints = false
        chequePostionLabel.text = "Front of the cheque"
        chequePostionLabel.font = .systemFont(ofSize: 14)
        chequePostionLabel.textColor = .systemGray2
        chequePostionLabel.textAlignment = .center
        return chequePostionLabel
    }()
    
    
    @objc private func didTapToView(tap : UITapGestureRecognizer) {
        guard let side = chequeSide else {return}
        delegate?.didRequestToOpenCamera(for: side)
    }
    
    private func updateImage() {
        DispatchQueue.main.async {
            if let image = self.chequeImage {
                self.chequeImageView.contentMode = .scaleAspectFill
                self.chequeImageView.image = image
            }else {
                self.chequeImageView.contentMode = .scaleAspectFit
                self.chequeImageView.image = self.dummyImage
            }
        }
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToView(tap:))))
        chequeImageView.image = dummyImage
        
        addSubview(chequeImageView)
        addSubview(chequePostionLabel)
        
        NSLayoutConstraint.activate([
            
            chequeImageView.topAnchor.constraint(equalTo: topAnchor),
            chequeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chequeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chequeImageView.bottomAnchor.constraint(equalTo: chequePostionLabel.topAnchor ,constant: -10),
            
            chequePostionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            chequePostionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            chequePostionLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -5),
            chequePostionLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
    
}
