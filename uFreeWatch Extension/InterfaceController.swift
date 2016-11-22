//
//  InterfaceController.swift
//  uFreeWatch Extension
//
//  Created by Omer Winrauke on 11/18/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session : WCSession?
    var shouldSegue = true
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session = WCSession.default()
        session?.delegate = self
        session?.activate()
        
        session?.sendMessage(["request" : "user"], replyHandler: { (response) in
                                print(response)

                if (response["available"] as! String == "true") {
                    CurrentUserWatch.setUserName(userName: response["User"] as! String)
                } else {
                    self.shouldSegue = false
                   self.presentController(withName: "login_error", context: nil)
                }
            }, errorHandler: { (error) in
                self.shouldSegue = false
                self.presentController(withName: "connection_error", context: nil)
            }
        )
       
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (CurrentUserWatch.getUserName() == "error") {
            self.presentController(withName: "connection_error", context: nil)
        } else if (CurrentUserWatch.getUserName() == "not loaded") {
            self.presentController(withName: "login_error", context: nil)
        }
        shouldSegue = true
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    @IBAction func findFriendButtonClicked(button: WKInterfaceButton) {
        if (shouldSegue) {
            presentController(withName: "Generate_Friend", context: nil)
        }
    }
    
    
//    
//    func sessionDidBecomeInactive(_ session: WCSession) {
//        
//    }
//    
//    func sessionDidDeactivate(_ session: WCSession) {
//        
//    }
    
}
