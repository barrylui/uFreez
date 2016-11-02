//
//  CurrentUser.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import Foundation

class CurrentUser {
    private static var userInitialized = false
    
    private static var userName = String()
    private static var passWord = String()
    
    private static var name = String()
    
    private static var friendsList = Array<String>()

    //dates not sure yet 
    
    private static var phoneNumber = String()
    
    static func initializeUser(unparsedUser: [String:AnyObject], sem: DispatchSemaphore) {
        if (unparsedUser["code"] == nil) {
            userName = unparsedUser["UserName"] as! String
            passWord = unparsedUser["Password"] as! String
            name = (unparsedUser["FirstAndLastName"] as! String).replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
            friendsList = unparsedUser["FriendList"] as! [String]
            userInitialized = true
        }
        sem.signal()
    }
    
    static func initializeUser(name: String, userName: String, passWord: String, phoneNumber:String) {
        self.name = name.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        self.userName = userName
        self.passWord = passWord
        self.phoneNumber = phoneNumber
        userInitialized = true
    }
    
    static func sanitizeFields() {
        userInitialized = false
        userName = String()
        passWord = String()
        name = String()
        friendsList = Array<String>()
        phoneNumber = String()
    }
    
    static func removeFromFriendsArray(index: Int) {
        friendsList.remove(at: index)
    }
    
    static func addToFriendsArray(friend: String) {
        friendsList.append(friend)
    }
    
    static func isUserInitialized() -> Bool {
        return userInitialized
    }
    
    static func getUserName() -> String {
        return userName
    }
    
    static func setName(name: String) {
        self.name = name.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
    }
    
    static func getPassWord() -> String {
        return passWord
    }
    
    static func setPassWord(passWord: String) {
        self.passWord = passWord
    }
    
    static func getName() -> String {
        return name.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
    }
    
    static func getNameForAsync() -> String {
        return name
    }
    
    static func getFriendsList() -> Array<String> {
        return friendsList
    }
    
    static func getPhoneNumber() -> String {
        return phoneNumber
    }
    
    static func setPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

}
