//
//  ConnectivityHandler.swift
//  uFree
//
//  Created by Omer Winrauke on 11/21/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation
import WatchConnectivity

class ConnectivityHandler : NSObject, WCSessionDelegate {
    
    var session = WCSession.default()
    
    override init() {
        super.init()
        
        session.delegate = self
        session.activate()
        
        NSLog("%@", "Paired Watch: \(session.isPaired), Watch App Installed: \(session.isWatchAppInstalled)")
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        NSLog("didReceiveMessage: %@", message)
        if message["request"] as? String == "user" {
            print("message received")
            if (isUserDataStored()) {
                let defaults = UserDefaults.standard
                replyHandler(["available" : "true" as AnyObject, "User": defaults.string(forKey: "UserName") as AnyObject])
                print("sending user data")
                
            } else {
                replyHandler(["available" : "false" as AnyObject])
            }
        }
    }
    
    private func isUserDataStored() -> Bool {
        let defaults = UserDefaults.standard
        return !(defaults.string(forKey: "UserName") == nil) && !(defaults.string(forKey: "Password") == nil)
    }
    
    func sendSanitizeUser() {
        session.sendMessage(["request" : "sanitize"], replyHandler: { (response) in
            print(response)
        }, errorHandler: { (error) in
            //            self.shouldSegue = false
            //            self.presentController(withName: "connection_error", context: nil)
        }
        )
    
    }
    
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        WCSession.default().activate()
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        WCSession.default().activate()
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default().activate()
    }
    
}
