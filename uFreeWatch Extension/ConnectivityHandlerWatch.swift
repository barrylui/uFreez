//
//  ConnectivityHandlerWatch.swift
//  uFree
//
//  Created by Omer Winrauke on 11/21/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation
import WatchConnectivity

class ConnectivityHandlerWatch : NSObject, WCSessionDelegate {
    
    var session = WCSession.default()
    
    override init() {
        super.init()
        
        session.delegate = self
        session.activate()
        
        session = WCSession.default()
        session.delegate = self
        session.activate()
        
        session.sendMessage(["request" : "user"], replyHandler: { (response) in
            print(response)
            
            if (response["available"] as! String == "true") {
                CurrentUserWatch.setUserName(userName: response["User"] as! String)
            } else {
                CurrentUserWatch.setUserName(userName: "not loaded")
//                self.shouldSegue = false
//                self.presentController(withName: "login_error", context: nil)
            }
        }, errorHandler: { (error) in
            CurrentUserWatch.setUserName(userName: "error")
//            self.shouldSegue = false
//            self.presentController(withName: "connection_error", context: nil)
        }
        )
        
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        NSLog("didReceiveMessage: %@", message)
        if message["request"] as? String == "sanitize" {
            print("message received")
            CurrentUserWatch.setUserName(userName: "not loaded")
        }
    }
    
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        WCSession.default().activate()
    }
}
