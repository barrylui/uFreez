//
//  CurrentUserWatch.swift
//  uFree
//
//  Created by Omer Winrauke on 11/18/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation


class CurrentUserWatch {

    private static var friendsList = Array<String>()
    
    static func setFriendsList(unparsedArray: [String:AnyObject]) {
        print(unparsedArray)
        let unParsedArray = unparsedArray["sched"] as! [String]
        for user in unParsedArray {
            print(user)
            let userArray = user.components(separatedBy: "-")
            friendsList.append(userArray[0].replacingOccurrences(of: "_", with: " ", options: .literal, range: nil))
        }
    }
    
    static func getFriendsList() -> Array<String> {
        return friendsList
    }
    
    static func sanitizeFriendsList() {
        friendsList = Array<String>()
    }
}
