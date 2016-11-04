//
//  ScheduleViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    private var amOrPm: Int = 0
    @IBOutlet var scheduleButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            loadSchedule(day: 1, amOrPm: 0)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scheduleButtonClicked(button: UIButton) {
        button.backgroundColor = button.backgroundColor == UIColor.red ? UIColor.blue : UIColor.red
        print(getCoordinates(location: button.tag)!)
    }

    private func loadSchedule(day: Int, amOrPm: Int) {
        print(CurrentUser.getSchedule()[day][amOrPm])
        var count = 0;
        for i in 0...CurrentUser.getSchedule()[day][amOrPm].count-1 {
            for j in 0...CurrentUser.getSchedule()[day][amOrPm][i].count-1 {
                
               // print("\(i) \(j) - \(scheduleButtons[i].tag)")
                //scheduleButtons[i].tag = count
                count = count + 1
                print("\(i) \(j) - \(scheduleButtons[i].tag)")
                scheduleButtons[i].backgroundColor = CurrentUser.getSchedule()[day][amOrPm][i][j] == 0 ? UIColor.blue : UIColor.red
            }
        }
    }
    
    private func getCoordinates(location: Int) -> (Int, Int)? {
        print(location)
        switch (location) {
        case 0:
            return (0,0)
        case 1:
            return (0,1)
        case 2:
            return (0,2)
        case 3:
            return (0,3)
        case 4:
            return (0,4)
        case 5:
            return (0,5)
        case 6:
            return (1,0)
        case 7:
            return (1,1)
        case 8:
            return (1,2)
        case 9:
            return (1,3)
        case 10:
            return (1,4)
        case 11:
            return (1,5)
        case 12:
            return (2,0)
        case 13:
            return (2,1)
        case 14:
            return (2,2)
        case 15:
            return (2,3)
        case 16:
            return (2,4)
        case 17:
            return (2,5)
        case 18:
            return (3,0)
        case 19:
            return (3,1)
        case 20:
            return (3,2)
        case 21:
            return (3,3)
        case 22:
            return (3,4)
        case 23:
            return (3,5)
        case 24:
            return (4,0)
        case 25:
            return (4,1)
        case 26:
            return (4,2)
        case 27:
            return (4,3)
        case 28:
            return (4,4)
        case 29:
            return (4,5)
        case 30:
            return (5,0)
        case 31:
            return (5,1)
        case 32:
            return (5,2)
        case 33:
            return (5,3)
        case 34:
            return (5,5)
        case 35:
            return (6,0)
        case 36:
            return (6,1)
        case 37:
            return (6,2)
        case 38:
            return (6,3)
        case 39:
            return (6,4)
        case 40:
            return (6,5)
        case 41:
            return (7,0)
        case 42:
            return (7,1)
        case 43:
            return (7,2)
        case 44:
            return (7,3)
        case 45:
            return (7,4)
        case 46:
            return (7,5)
        default:
            return nil
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
