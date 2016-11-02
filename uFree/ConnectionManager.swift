//
//  ConnectionManager.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation

class ConnectionManager {
    private static let serverAddress = "http://localhost:8081/"
    
    static func deleteFriend(userName: String, friendName: String) {
        let url = NSURL(string: (serverAddress+"deleteFriend/"+userName+"/"+friendName))
        makeAsyncCall(url: url!)
    }
    
    static func addFriend(userName: String, friendName: String) {
        let url = NSURL(string: (serverAddress+"addFriend/"+userName+"/"+friendName))
        makeAsyncCall(url: url!)
    }
    
    static func updateName(userName: String, name: String) {
        let url = NSURL(string: (serverAddress+"updateName/"+userName+"/"+name))
        makeAsyncCall(url: url!)
    }
    
    static func updatePhoneNumber(userName: String, phoneNumber: String) {
        let url = NSURL(string: (serverAddress+"updatePhoneNumber/"+userName+"/"+phoneNumber))
        makeAsyncCall(url: url!)
    }
    
    static func updatePassword(userName: String, password: String) {
        let url = NSURL(string: (serverAddress+"updatePassword/"+userName+"/"+password))
        makeAsyncCall(url: url!)
    }
    
    private static func makeAsyncCall(url: NSURL) {
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                //nothing to recieve
                print("i think we did it")
            } catch {
            }
        }
        task.resume()
    }
    
    static func loginUser(userName: String, passWord: String, view: UIViewController) {
        let url = NSURL(string: (serverAddress+"login/"+userName+"/"+passWord))
        let preParsedUserInfo = getJSONObject(url: url!, view: view)
        print(preParsedUserInfo)
        
        //CurrentUser.initializeUser(upresentViewController(nextViewController, animated: true, completion: nil)nparsedUser: preParsedUserInfo as! [String : AnyObject])
    }

    private static func getJSONObject(url: NSURL, view: UIViewController) -> NSDictionary {
        let sem = DispatchSemaphore(value: 0);
        
        var jsonObject = NSDictionary()
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                CurrentUser.initializeUser(unparsedUser: jsonObject as! [String : AnyObject], sem: sem)
                //sem.signal()
            } catch {
            }
        }
        task.resume()
        sem.wait(timeout: DispatchTime.distantFuture)
        if (CurrentUser.isUserInitialized()) {
            let controller = view.storyboard?.instantiateViewController(withIdentifier: "sw_reveal")
            view.present(controller!, animated: true, completion: nil)
        } else {
            print("an error should be thrown here") // *******************
        }
        return jsonObject
    }
}
