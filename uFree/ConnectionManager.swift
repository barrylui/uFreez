//
//  ConnectionManager.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation

class ConnectionManager {
    //private static let serverAddress = "http://localhost:8081/"
    private static let serverAddress = "https://ufreeserver.com:8443/"
    private static let PASS_CODE = 200
    private static let JSON_PASS_FAIL = "code"
    
    static func sendFriendAcceptedNotification(userName: String, friend: String) {
        let urlRequest = "\(serverAddress)sendPushAcceptedFriendRequest/\(userName)/\(friend)"
        let url = NSURL(string: urlRequest)
        makeAsyncCall(url: url!)
    }
    
    static func sendFriendAddedNotification(userName: String, friend: String) {
        let urlRequest = "\(serverAddress)sendPushFriendRequest/\(userName)/\(friend)"
        let url = NSURL(string: urlRequest)
        makeAsyncCall(url: url!)
    }
    
    static func setDeviceAvailibility(userName: String, bool: String) {
        let urlRequest = "\(serverAddress)setDeviceAvailability/\(userName)/\(bool)"
        print("asyn sent", urlRequest)
        let url = NSURL(string: urlRequest)
        makeAsyncCall(url: url!)
    }
    
    static func setDeviceToken(userName: String, token: String) {
        let urlRequest = "\(serverAddress)setDeviceToken/\(userName)/\(token)"
        print("asyn sent", urlRequest)
        let url = NSURL(string: urlRequest)
        makeAsyncCall(url: url!)
        if (token == "nil") {
            setDeviceAvailibility(userName: userName, bool: "false")
        } else {
            setDeviceAvailibility(userName: userName, bool: "true")
        }
    }
    
    static func updateAvalabilityOverride(userName: String, value: Int) {
        let urlRequest = "\(serverAddress)setAvailableOverride/\(userName)/\(value)"
        let url = NSURL(string: urlRequest)
        makeAsyncCall(url: url!)
    }
    
    static func updateSchedule(userName: String, day: String, amOrPm:Int, hour: Int, min: Int, value: Int) {
        let urlRequest = "\(serverAddress)updateDay/\(userName)/\(day)/\(amOrPm)/\(hour)/\(min)/\(value)"
        print("\(serverAddress)updateDay/\(userName)/\(day)/\(amOrPm)/\(hour)/\(min)/\(value)")
        let url = NSURL(string: urlRequest)
        makeAsyncCall(url: url!)
    }
    
    static func deleteFriend(userName: String, friendName: String) {
        let url = NSURL(string: (serverAddress+"deleteFriend/"+userName+"/"+friendName))
        makeAsyncCall(url: url!)
    }
    
    static func addFriendRequest(userName: String, friendName: String) {
        let url = NSURL(string: (serverAddress+"addFriendRequest/"+userName+"/"+friendName))
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
    
    static func createUser(userName: String, password: String, telephone: String, name: String, view: UIViewController) {
       addUserWithCheck(userName: userName, password: password, telephone: telephone, name: name, view: view)
    }

    static func getAvailableFriends(username: String, tableView: UITableView, view:UIViewController) {
        let url = NSURL(string: (serverAddress+"checkAvailability/"+username))
        getJSONObjectFriends(url: url!, tableView: tableView, view: view)
    }
    
    static func getFriendsRequests(username: String, tableView: UITableView, view:UIViewController) {
        let url = NSURL(string: (serverAddress+"getFriendRequests/"+username))
        getJSONObjectFriendRequest(url: url!, tableView: tableView, view: view)
    }
    
    static func getFriends(username: String, tableView: UITableView, view:UIViewController) {
        let url = NSURL(string: (serverAddress+"getFriends/"+username))
        getJSONObjectFriendsList(url: url!, tableView: tableView, view: view)
        tableView.clearsContextBeforeDrawing = true
        tableView.reloadData()
    }
    
    private static func getJSONObjectFriends(url: NSURL, tableView: UITableView, view:UIViewController) {
        let sem = DispatchSemaphore(value: 0);
        
        var jsonObject = NSDictionary()
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                //print(jsonObject)
                CurrentUser.sanitizeAvailableFriends()
                CurrentUser.setAvailableFriends(unparsedArray: jsonObject as! [String : AnyObject])
                tableView.reloadData()
                //print(tableView.ce)
                sem.signal()
            } catch {
            }
        }
        task.resume()
        sem.wait(timeout: DispatchTime.distantFuture)
        tableView.reloadData()
    }
    
    private static func getJSONObjectFriendRequest(url: NSURL, tableView: UITableView, view:UIViewController) {
        let sem = DispatchSemaphore(value: 0);
        
        var jsonObject = NSDictionary()
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                //print(jsonObject)
                CurrentUser.sanitizeFriendRequests()
                CurrentUser.setAvailableFriendRequest(unparsedArray: jsonObject as! [String : AnyObject])
                tableView.reloadData()
                //print(tableView.ce)
                sem.signal()
            } catch {
            }
        }
        task.resume()
        sem.wait(timeout: DispatchTime.distantFuture)
        //tableView.reloadData()
    }

    
    private static func getJSONObjectFriendsList(url: NSURL, tableView: UITableView, view:UIViewController) {
        let sem = DispatchSemaphore(value: 0);
        
        var jsonObject = NSDictionary()
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                //print(jsonObject)
                CurrentUser.sanitizeFriends()
                CurrentUser.setFriendsList(unparsedArray: jsonObject as! [String : AnyObject])
                tableView.reloadData()
                //print(tableView.ce)
                sem.signal()
            } catch {
            }
        }
        task.resume()
        sem.wait(timeout: DispatchTime.distantFuture)
        tableView.reloadData()
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
        //print(preParsedUserInfo)
        
        //CurrentUser.initializeUser(upresentViewController(nextViewController, animated: true, completion: nil)nparsedUser: preParsedUserInfo as! [String : AnyObject])
    }

    static func addFriendWithCheck(userName: String, friendName: String, view:UIViewController) {
        print("friendslist", CurrentUser.getFriendRequestList().index(of: friendName))
        if (friendName == CurrentUser.getUserName() || CurrentUser.getFriendsList().index(of: friendName) != nil || CurrentUser.getFriendRequestList().index(of: friendName) != nil) {
            
            let alert = UIAlertController(title: "Error!", message: "Cannot add a user that has been sent a friend request or is your friend", preferredStyle: .alert)
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                
            }))
            view.present(alert, animated: true, completion: nil)
            
        } else {
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
            let code = jsonObject[JSON_PASS_FAIL]
            if (code as! Int  == PASS_CODE) {
                addFriendRequest(userName: userName, friendName: friendName)
                sendFriendAddedNotification(userName: userName, friend: friendName)
            } else {
               
                print("an error should be thrown here") // *******************
                let alert = UIAlertController(title: "Error!", message: "The user you entered is not a valid user name!", preferredStyle: .alert)
                
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                    
                }))
                view.present(alert, animated: true, completion: nil)
                print()
                //CurrentUser.removeFromFriendRequestArray(location: CurrentUser.getFriendsList().count-1)
            
            }
        }
    }
        
        
        
        
    
    private static func addUserWithCheck(userName: String, password: String, telephone: String, name: String, view: UIViewController) {
        //let url = NSURL(string: (serverAddress+"createUser/"+userName+"/"+password+"/"+telephone+"/"+name))
        let sem = DispatchSemaphore(value: 0);
        let url = NSURL(string: (serverAddress+"checkUserExist/"+userName))
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
        let code = jsonObject[JSON_PASS_FAIL]
        if (code as! Int  != PASS_CODE) {
            let url = NSURL(string: (serverAddress+"createUser/"+userName+"/"+password+"/"+telephone+"/"+name))
            makeAsyncCall(url: url!)
            //addFriend(userName: userName, friendName: friendName)
        } else {
            print("an error should be thrown here") // *******************
            let alert = UIAlertController(title: "Error!", message: "The user you entered is already taken!", preferredStyle: .alert)
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                
            }))
            view.present(alert, animated: true, completion: nil)
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
            let alert = UIAlertController(title: "Error!", message: "Invalid user name or password", preferredStyle: .alert)
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                
            }))
            view.present(alert, animated: true, completion: nil)
            
        }
        return jsonObject
    }
}
