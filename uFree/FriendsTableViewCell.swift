//
//  FriendsTableViewCell.swift
//  uFree
//
//  Created by Omer Winrauke on 10/30/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    @IBOutlet var friendsLabel:UILabel!
    
    @IBOutlet var rounder: UIView!
    
override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
