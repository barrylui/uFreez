//
//  AccountViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var passWordTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var issueLabel: UILabel!
    @IBOutlet var friendsTable: UITableView!
    @IBOutlet var availabilitySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if (CurrentUser.getAvailabilityOverride() == 1) {
            availabilitySwitch.setOn(false, animated: true)
        } else {
            availabilitySwitch.setOn(true, animated: true)
        }
        
        friendsTable!.delegate = self
        friendsTable!.dataSource = self
        passWordTextField!.delegate = self
        phoneNumberTextField!.delegate = self
        nameTextField!.delegate = self
        
        nameTextField.text = CurrentUser.getName()
        userNameLabel.text = CurrentUser.getUserName()
        passWordTextField.text = CurrentUser.getPassWord()
        phoneNumberTextField.text = CurrentUser.getPhoneNumber()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutButtonClicked(butto: UIBarButtonItem) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "login_page")
        self.present(controller!, animated: true, completion: nil)
        CurrentUser.sanitizeFields()
    }
    
    @IBAction func saveButtonClicked(button:UIBarButtonItem) {
        // should be an http call to update the fields
        if (passWordTextField.text == "" || phoneNumberTextField.text == ""){
            issueLabel.text = "You cannot leave fields blank!"
            issueLabel.textColor = UIColor.red
        } else {
            if (CurrentUser.getName() != nameTextField.text) {
                CurrentUser.setName(name: nameTextField.text!)
                ConnectionManager.updateName(userName: CurrentUser.getUserName(), name: nameTextField.text!.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil))
            }
            if (CurrentUser.getPassWord() != passWordTextField.text) {
                CurrentUser.setPassWord(passWord: passWordTextField.text!)
                ConnectionManager.updatePassword(userName: CurrentUser.getUserName(), password: passWordTextField.text!)            }
            
            if (CurrentUser.getPhoneNumber() != phoneNumberTextField.text) {
                CurrentUser.setPhoneNumber(phoneNumber: phoneNumberTextField.text!)
                ConnectionManager.updatePhoneNumber(userName: CurrentUser.getUserName(), phoneNumber: phoneNumberTextField.text!)
            }
            issueLabel.text = "Saved!"
            issueLabel.textColor = UIColor.blue
        }
    }
    
    @IBAction func refreshFriendButtonClicked(button: UIButton) {
        ConnectionManager.getFriends(username: CurrentUser.getUserName(), tableView: friendsTable, view: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(CurrentUser.getFriendsList().count)
        return CurrentUser.getFriendsList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! FriendsTableViewCell
        cell.friendsLabel.text = CurrentUser.getFriendsList()[indexPath.row]
        print("here")
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
    
    @IBAction func addNewFriendButtonClicked(button: UIButton) {
        let alert = UIAlertController(title: "Add User", message: "Enter the user name of the friend you want to add", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            let textField = alert.textFields![0] // Force unwrapping because we know it exists.
            if (textField.text != "") {
                //CurrentUser.addToFriendsArray(friend: textField.text!)
                ConnectionManager.addFriendRequest(userName: CurrentUser.getUserName(), friendName: textField.text!)
                self.friendsTable.reloadData()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func userTappedBackground(gestureRecognizer: UITapGestureRecognizer) {
        nameTextField?.resignFirstResponder()
        passWordTextField?.resignFirstResponder()
        phoneNumberTextField?.resignFirstResponder()
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if sender.isOn {
            ConnectionManager.updateAvalabilityOverride(userName: CurrentUser.getUserName(), value: 0)
            CurrentUser.setAvailabilityOverride(value: 0)
        } else {
            ConnectionManager.updateAvalabilityOverride(userName: CurrentUser.getUserName(), value: 1)
            CurrentUser.setAvailabilityOverride(value: 1)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.tag != 1) {
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return !prospectiveText.contains(" ")
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
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
