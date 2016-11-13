//
//  InterfaceController.swift
//  uFreeWatch Extension
//
//  Created by Omer Winrauke on 11/9/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let defaults = UserDefaults(suiteName: "group.com.CIS444.owinrauke.uFree.preferences")
        let user = String(describing: defaults?.object(forKey: "name_preference"))
        print("!!", user)
        //let userName = 2 //.contentsOfFile("Root.plist")["name_preference"]
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
