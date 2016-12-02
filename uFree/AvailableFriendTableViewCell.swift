//
//  AvailableFriendTableViewCell.swift
//  uFree
//
//  Created by Omer Winrauke on 11/8/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit
import MessageUI

class AvailableFriendTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet weak var round2: UIView!
    @IBOutlet var timeBigLabel: UILabel!
    @IBOutlet var view: UIViewController!
    @IBOutlet var friendImageView: UIImageView?
    
    var phoneNumber: String = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func smsButtonClicked(button: UIButton) {
        print(phoneNumber)
    }
}
