//
//  LangingPageViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class LangingPageViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollView.contentSize.height = 2000
        
        
        storeUserData()
        if(UIApplication.shared.isRegisteredForRemoteNotifications) {
            ConnectionManager.setDeviceToken(userName: CurrentUser.getUserName(), token: CurrentUser.getDeviceToken())
            print("enabled push notifications")
        } else {
            ConnectionManager.setDeviceAvailibility(userName: CurrentUser.getUserName(), bool: "false")
            print("disabled push notifications")
        }
        
        welcomeLabel.text = "Hello \(CurrentUser.getName())"
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func storeUserData() {
        let defaults = UserDefaults.standard
        print("storing the data")
        defaults.setValue(CurrentUser.getUserName(), forKey: "UserName")
        defaults.setValue(CurrentUser.getPassWord(), forKey: "Password")
        
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
