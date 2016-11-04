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

    private static var schedule = Array<Array<Array<Array<Int>>>>()
    
    private static var phoneNumber = String()
    
    static func initializeUser(unparsedUser: [String:AnyObject], sem: DispatchSemaphore) {
        if (unparsedUser["code"] == nil) {
            userName = unparsedUser["UserName"] as! String
            passWord = unparsedUser["Password"] as! String
            name = (unparsedUser["FirstAndLastName"] as! String).replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
            friendsList = unparsedUser["FriendList"] as! [String]
            phoneNumber = unparsedUser["PhoneNumber"] as! String
            loadSchedule(unparsedUser: unparsedUser)
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
        loadScheduleForNewUser()
    }
    
    static func sanitizeFields() {
        userInitialized = false
        userName = String()
        passWord = String()
        name = String()
        friendsList = Array<String>()
        phoneNumber = String()
        schedule = Array<Array<Array<Array<Int>>>>()
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

    static func getSchedule() -> Array<Array<Array<Array<Int>>>> {
        return schedule
    }
    
    static func setSchedule(day:Int, amOrPm:Int, tuple:(Int, Int), value:Int) {
        schedule[day][amOrPm][tuple.0][tuple.1] = value
    }
    
    private static func loadSchedule(unparsedUser: [String:AnyObject]) {
        schedule.append(unparsedUser["Sun"] as! [[[Int]]])
        schedule.append(unparsedUser["Mon"] as! [[[Int]]])
        schedule.append(unparsedUser["Tues"] as! [[[Int]]])
        schedule.append(unparsedUser["Wed"] as! [[[Int]]]) 
        schedule.append(unparsedUser["Thur"] as! [[[Int]]])
        schedule.append(unparsedUser["Fri"] as! [[[Int]]])
        schedule.append(unparsedUser["Sat"] as! [[[Int]]])
    }
    
    private static func loadScheduleForNewUser() {
        var day = [[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0], [0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]]
        
        for _ in 0...6 {
            schedule.append(day)
        }
    }
}
