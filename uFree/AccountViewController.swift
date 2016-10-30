//
//  AccountViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passWordTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var issueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        nameLabel.text = CurrentUser.getName()
        userNameTextField.text = CurrentUser.getUserName()
        passWordTextField.text = CurrentUser.getPassWord()
        phoneNumberTextField.text = CurrentUser.getPhoneNumber()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonClicked(button:UIButton) {
        // should be an http call to update the fields
        if (userNameTextField.text == "" || passWordTextField.text == "" || phoneNumberTextField.text == ""){
            issueLabel.text = "You cannot leave fields blank!"
            issueLabel.textColor = UIColor.red
        } else {
            CurrentUser.setUserName(userName: userNameTextField.text!)
            CurrentUser.setPassWord(userName: passWordTextField.text!)
            CurrentUser.setPhoneNumber(phoneNumber: phoneNumberTextField.text!)
            issueLabel.text = "Saved!"
            issueLabel.textColor = UIColor.blue
        }
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
