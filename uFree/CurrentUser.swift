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
    private static var friendsRequestList = Array<String>()
    private static var schedule = Array<Array<Array<Array<Int>>>>()
    private static var phoneNumber = String()
    private static var availabilityOverride = Int()
    
    private static var deviceToken = String()
    
    private static var availableFriends = Array<AvailableFriends>()
    
    static func initializeUser(unparsedUser: [String:AnyObject], sem: DispatchSemaphore) {
        if (unparsedUser["code"] == nil) {
            userName = unparsedUser["UserName"] as! String
            passWord = unparsedUser["Password"] as! String
            name = (unparsedUser["FirstAndLastName"] as! String).replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
            friendsList = unparsedUser["FriendList"] as! [String]
            friendsRequestList = unparsedUser["FriendRequestList"] as! [String]
            phoneNumber = unparsedUser["PhoneNumber"] as! String
            availabilityOverride = unparsedUser["AvailabileOverride"] as! Int
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
        availabilityOverride = 0
        loadScheduleForNewUser()
    }
    
    static func sanitizeFields() {
        userInitialized = false
        userName = String()
        passWord = String()
        name = String()
        friendsList = Array<String>()
        friendsRequestList = Array<String>()
        phoneNumber = String()
        availabilityOverride = Int()
        availableFriends = Array<AvailableFriends>()
        schedule = Array<Array<Array<Array<Int>>>>()
        deviceToken = String()
    }
    
    static func setDeviceToken(token: String) {
        self.deviceToken = token
    }
    
    static func getDeviceToken() -> String {
        return deviceToken
    }
    
    static func removeFromFriendsArray(index: Int) {
        friendsList.remove(at: index)
    }
    
    static func addToFriendsArray(friend: String) {
        friendsList.append(friend)
    }
    
    static func addToFriendRequestArray(friend: String) {
        friendsRequestList.append(friend)
    }

    static func removeFromFriendRequestArray(location: Int) {
        friendsRequestList.remove(at: location)
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
        print("the password is \(passWord.hash)")
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
    
    static func getAvailabilityOverride () -> Int {
        return availabilityOverride
    }
    
    static func setAvailabilityOverride(value: Int) {
        availabilityOverride = value
    }
    
    static func setAvailableFriends(unparsedArray: [String:AnyObject]) {
        let unParsedArray = unparsedArray["sched"] as! [String]
        for user in unParsedArray {
            var arr = user.characters.split{$0 == "-"}.map(String.init)
            print(arr)
            var time = 0
            if(arr[1] == "**15") {
                time = -15
            } else {
                time = Int(arr[1])!
            }
            availableFriends.append(AvailableFriends(name: arr[0], time: time, phoneNumber: arr[2]))
        }
    }
    
    static func setAvailableFriendRequest(unparsedArray: [String:AnyObject]) {
        print(unparsedArray)
        let unParsedArray = unparsedArray["FriendRequests"] as! [String]
        for user in unParsedArray {
            print(user)
            friendsRequestList.append(user)
        }
    }
    
    static func setFriendsList(unparsedArray: [String:AnyObject]) {
        print(unparsedArray)
        let unParsedArray = unparsedArray["Friends"] as! [String]
        for user in unParsedArray {
            print(user)
            friendsList.append(user)
        }
    }
    
    static func sanitizeAvailableFriends() {
        availableFriends = Array<AvailableFriends>()
    }
    
    static func sanitizeFriends() {
        friendsList = Array<String>()
    }
    
    static func sanitizeFriendRequests() {
        friendsRequestList = Array<String>()
    }
    
    static func getAvailableFriends() -> Array<AvailableFriends>{
        return availableFriends
    }
    
    static func getFriendRequestList() -> Array<String> {
        return friendsRequestList
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
        let day = [[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0], [0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]]
        
        for _ in 0...6 {
            schedule.append(day)
        }
    }
}

class AvailableFriends{
    private var time: Int
    private var name: String
    private var phoneNumber: String
    
    init (name:String, time:Int, phoneNumber:String) {
        self.time = time
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    func getName() -> String {
        return name
    }
    
    func getTime() -> Int {
        return time
    }
    
    func getPhoneNumber() -> String {
        return phoneNumber
    }
};
