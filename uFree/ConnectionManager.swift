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
    
    static func createUser(userName: String, password: String, telephone: String, name: String) {
        let url = NSURL(string: (serverAddress+"createUser/"+userName+"/"+password+"/"+telephone+"/"+name))
        makeAsyncCall(url: url!)
    }

    private static func makeAsyncCall(url: NSURL) {
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                //nothing to recieve
                print("i think we did it")
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

    static func addFriendWithCheck(userName: String, friendName: String, view:UIViewController) {
        let sem = DispatchSemaphore(value: 0);
        let url = NSURL(string: (serverAddress+"checkUserExist/"+friendName))

        var jsonObject = NSDictionary()
        let task = URLSession.shared.dataTask(with: url as! URL) { (data, response, error) in
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                sem.signal()
            } catch {
            }
        }
        task.resume()
        sem.wait(timeout: DispatchTime.distantFuture)
        //var dic: [String : AnyObject] = jsonObject as! [String : String] as [String : AnyObject]
        let code = jsonObject["code"]
        if (code as! Int  == 200) {
           addFriend(userName: userName, friendName: friendName)
        } else {
            print("an error should be thrown here") // *******************
            let alert = UIAlertController(title: "Error!", message: "The user you entered is not a valid user name!", preferredStyle: .alert)
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
               
            }))
            view.present(alert, animated: true, completion: nil)
            CurrentUser.removeFromFriendsArray(index: CurrentUser.getFriendsList().count-1)
        }
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
