//
//  GenerateFreeFriendsTableViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit
import MessageUI

class GenerateFreeFriendsTableViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //print(CurrentUser.getUserName())
        ConnectionManager.getAvailableFriends(username: CurrentUser.getUserName(), tableView: tableView, view: self)
//        self.tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CurrentUser.getAvailableFriends().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AvailableFriendTableViewCell = tableView.dequeueReusableCell(withIdentifier: "friend_cell", for: indexPath) as! AvailableFriendTableViewCell
        cell.nameLabel.text = CurrentUser.getAvailableFriends()[indexPath.row].getName()
        //cell.view = self
        var time = String()
        if (CurrentUser.getAvailableFriends()[indexPath.row].getTime() > 45) {
            time = "Free for roughly an hour or more"
        } else if (CurrentUser.getAvailableFriends()[indexPath.row].getTime() < 0) {
            time = "Will be free in roughly \(abs(CurrentUser.getAvailableFriends()[indexPath.row].getTime())) minutes"
        } else {
            time = "Free for roughly \(abs(CurrentUser.getAvailableFriends()[indexPath.row].getTime())) minutes"
        }
        cell.timeLabel.text = time
        cell.phoneNumber = CurrentUser.getAvailableFriends()[indexPath.row].getPhoneNumber()
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let sms = UITableViewRowAction(style: .normal, title: "Send SMS") { action, index in
            print("more button tapped")
            let messageVC = MFMessageComposeViewController()
            
            messageVC.body = "Enter a message";
            messageVC.recipients = ["111111111"]
            messageVC.messageComposeDelegate = self;
            
            if (MFMessageComposeViewController.canSendText()) {
                self.present(messageVC, animated: false, completion: nil)
            }
            self.tableView.reloadData()
            
        }
        sms.backgroundColor = UIColor.green
        
        return [sms]
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case MessageComposeResult.cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            let nameOfUser = CurrentUser.getFriendsList()[indexPath.row]
//            ConnectionManager.deleteFriend(userName: CurrentUser.getUserName(), friendName: nameOfUser)
//            CurrentUser.removeFromFriendsArray(index: indexPath.row)
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
//            //http request to make sure that user is removed from array
//        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
