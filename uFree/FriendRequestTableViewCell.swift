//
//  FriendRequestTableViewCell.swift
//  uFree
//
//  Created by Omer Winrauke on 11/14/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class FriendRequestTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    var requester: String = ""
    var table = UITableView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func approveFriendRequest(button: UIButton) {
        ConnectionManager.addFriend(userName: CurrentUser.getUserName(), friendName: requester)
        ConnectionManager.addFriend(userName: requester, friendName: CurrentUser.getUserName())
        CurrentUser.addToFriendsArray(friend: requester)
        var location = CurrentUser.getFriendRequestList().index(of: requester)
        CurrentUser.removeFromFriendRequestArray(location: location!)
        table.reloadData()
    }
}
