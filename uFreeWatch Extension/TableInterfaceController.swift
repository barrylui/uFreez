//
//  TableInterfaceController.swift
//  uFree
//
//  Created by Omer Winrauke on 11/18/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import WatchKit
import UIKit

class TableInterfaceController: WKInterfaceController {
    @IBOutlet var tableView: WKInterfaceTable!

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print(isUserDataStored())
        ConnectionManagerWatch.getAvailableFriends(username: "omer")
        tableView.setNumberOfRows(CurrentUserWatch.getFriendsList().count, withRowType: "MainRowType")
        print("set number of rows", CurrentUserWatch.getFriendsList().count)
        for i in 0..<CurrentUserWatch.getFriendsList().count {
            let row = tableView.rowController(at: i) as! cell
            row.label.setText(CurrentUserWatch.getFriendsList()[i])
        }
        
        // Configure interface objects here.
    }
    
    private func isUserDataStored() -> Bool {
        let defaults = UserDefaults.standard
        return !(defaults.string(forKey: "UserName") == nil) && !(defaults.string(forKey: "Password") == nil)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        // ConnectionManagerWatch.getAvailableFriends(username: "omer")
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        CurrentUserWatch.sanitizeFriendsList()
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
       // self.pushController(withName: "details", context: CurrentUserWatch.getFriendsList()[rowIndex])
    }
    
}

class cell: NSObject{
    @IBOutlet var label:WKInterfaceLabel!
    
    
};



