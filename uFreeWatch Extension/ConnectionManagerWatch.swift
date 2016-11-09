//
//  ConnectionManagerWatch.swift
//  uFree
//
//  Created by Omer Winrauke on 11/9/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation
import WatchKit

class ConnectionManager {
    private static let serverAddress = "http://uFree-Server-dev.us-west-2.elasticbeanstalk.com/"
    
    static func getAvailableFriends(username: String, tableView: WKInterfaceTable) {
        let url = NSURL(string: (serverAddress+"checkAvailability/"+username))
        getJSONObjectFriends(url: url!, tableView: tableView)
    }
    
    private static func getJSONObjectFriends(url: NSURL, tableView: WKInterfaceTable) {
        let sem = DispatchSemaphore(value: 0);
        
        var jsonObject = NSDictionary()
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                print(jsonObject)
                //ConnectionManager.
                CurrentUser.sanitizeAvailableFriends()
                CurrentUser.setAvailableFriends(unparsedArray: jsonObject as! [String : AnyObject])
                //tableView.re
                //print(tableView.ce)
                sem.signal()
            } catch {
            }
        }
        task.resume()
        sem.wait(timeout: DispatchTime.distantFuture)
        //tableView.reloadData()
    }

};
