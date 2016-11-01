//
//  AccountViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var passWordTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var issueLabel: UILabel!
    @IBOutlet var friendsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        friendsTable!.delegate = self
        friendsTable!.dataSource = self
        
        nameLabel.text = CurrentUser.getName()
        userNameLabel.text = CurrentUser.getUserName()
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
        if (passWordTextField.text == "" || phoneNumberTextField.text == ""){
            issueLabel.text = "You cannot leave fields blank!"
            issueLabel.textColor = UIColor.red
        } else {
            if (CurrentUser.getPassWord() != passWordTextField.text) {
                CurrentUser.setPassWord(userName: passWordTextField.text!)
                //make http request for change
            }
            
            if (CurrentUser.getPhoneNumber() != phoneNumberTextField.text) {
                CurrentUser.setPhoneNumber(phoneNumber: phoneNumberTextField.text!)
                //make http request for change
            }
            issueLabel.text = "Saved!"
            issueLabel.textColor = UIColor.blue
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CurrentUser.getFriendsList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! FriendsTableViewCell
        cell.friendsLabel.text = CurrentUser.getFriendsList()[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
           
            let nameOfUser = CurrentUser.getFriendsList()[indexPath.row]
            ConnectionManager.deleteFriend(userName: CurrentUser.getUserName(), friendName: nameOfUser)
            CurrentUser.removeFromFriendsArray(index: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            //http request to make sure that user is removed from array
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
