//
//  DepositTableViewCell.swift
//  DepositsFramework
//
//  Created by Sayooj Krishnan  on 16/07/21.
//

import UIKit

class DepositTableViewCell: UITableViewCell {

    var depositViewModel : DepositViewModel? {
        didSet {
            amountLabel.text = depositViewModel?.amountString
            descriptionLabel.text = depositViewModel?.description
            dateLabel.text = depositViewModel?.date
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
