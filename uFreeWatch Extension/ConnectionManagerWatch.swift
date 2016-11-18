//
//  ConnectionManagerWatch.swift
//  uFree
//
//  Created by Omer Winrauke on 11/18/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation
import WatchKit

class ConnectionManagerWatch {
    
    private static let serverAddress = "https://ufreeserver.com:8443/"
    
    static func getAvailableFriends(username: String) {
        let url = NSURL(string: (serverAddress+"checkAvailability/"+username))
        getJSONObjectFriendsList(url: url!)
    }
    
    private static func getJSONObjectFriendsList(url: NSURL) {
        let sem = DispatchSemaphore(value: 0);
        
        var jsonObject = NSDictionary()
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                print(jsonObject)
          //      CurrentUser.sanitizeFriends()
                CurrentUserWatch.setFriendsList(unparsedArray: jsonObject as! [String : AnyObject])
               // tableView.reloadData()
                //print(tableView.ce)
                sem.signal()
            } catch {
            }
        }
        task.resume()
        sem.wait(timeout: DispatchTime.distantFuture)
      //  tableView.reload
      //  tableView.reloadData()
    }
}
