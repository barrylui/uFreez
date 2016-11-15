//
//  FriendRequestTableViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 11/14/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class FriendRequestTableViewController: UITableViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    //@IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.tableView.clearsContextBeforeDrawing = true
        ConnectionManager.getFriendsRequests(username: CurrentUser.getUserName(), tableView: self.tableView, view: self)
        if (CurrentUser.getFriendsList().count == 0) {
            let alert = UIAlertController(title: "Alert!", message: "There are no friend requests available at this time", preferredStyle: .alert)
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        print("number", CurrentUser.getFriendRequestList().count)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(CurrentUser.getFriendsList().count)
        return CurrentUser.getFriendsList().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! FriendsTableViewCell
        cell.friendsLabel.text = CurrentUser.getFriendsList()[indexPath.row]
        print("here")
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let nameOfUser = CurrentUser.getFriendsList()[indexPath.row]
            ConnectionManager.deleteFriend(userName: CurrentUser.getUserName(), friendName: nameOfUser)
            CurrentUser.removeFromFriendsArray(index: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            //http request to make sure that user is removed from array
        }
    }


//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return CurrentUser.getFriendRequestList().count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "friend_request", for: indexPath) as! FriendRequestTableViewCell
//
//        cell.label.text = CurrentUser.getFriendRequestList()[indexPath.row]
//        cell.requester = CurrentUser.getFriendRequestList()[indexPath.row]
//        cell.table = self.tableView
//        
//        return cell
//    }
 

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
