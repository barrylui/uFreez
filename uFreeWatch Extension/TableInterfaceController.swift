//
//  TableInterfaceController.swift
//  uFreeWatch
//
//  Created by Omer Winrauke on 11/7/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit
import WatchKit

class TableInterfaceController: WKInterfaceController {
    
    @IBOutlet var tableView: WKInterfaceTable!
    private var arr = ["omer", "ben", "tania", "leor", "hai"]
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        ConnectionManager.getAvailableFriends(username: "omer", tableView: tableView)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        tableView.setNumberOfRows(CurrentUser.getAvailableFriends().count, withRowType: "MainRowType")
        for i in 0..<CurrentUser.getAvailableFriends().count {
            let row = tableView.rowController(at: i) as! cell
            print("unrwaped \(CurrentUser.getAvailableFriends()[i].getName())")
            row.label.setText(CurrentUser.getAvailableFriends()[i].getName())
        }
        
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "details", context: arr[rowIndex])
    }

}

class cell: NSObject{
    @IBOutlet var label:WKInterfaceLabel!
    
    
};
