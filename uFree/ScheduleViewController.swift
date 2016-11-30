//
//  ScheduleViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet var scheduleButtons1: [UIButton]!
    @IBOutlet var scheduleButtons2: [UIButton]!
    @IBOutlet var scheduleButtons3: [UIButton]!
    @IBOutlet var scheduleButtons4: [UIButton]!
    @IBOutlet var tabBar: UITabBar!
    @IBOutlet var dayLabel: UILabel!
    
    private var schedule2Darray: [[UIButton]] = []
    private var currentDay = 0
    private var amOrPm: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.delegate = self
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        schedule2Darray.append(scheduleButtons1)
        schedule2Darray.append(scheduleButtons2)
        schedule2Darray.append(scheduleButtons3)
        schedule2Darray.append(scheduleButtons4)
        //loadSchedule(day: currentDay, amOrPm: amOrPm)
        updateDayLabel(day: currentDay)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        currentDay = item.tag
        //loadSchedule(day: currentDay, amOrPm: amOrPm)
        updateDayLabel(day: currentDay)
    }

    
    @IBAction func scheduleButtonClicked(button: UIButton) {
        if (button.currentImage == UIImage(named: "red butt.png"))
        {
            button.setImage(UIImage(named: "green butt.png"), for: .normal)
        } else {
            button.setImage(UIImage(named: "red butt.png"), for: .normal)
        }
        
        //if let image = UIImage(named: "red butt.png")
        //{
        //    button.setImage(UIImage(named:"green butt.png"), for: .normal)
        //}
        //if let image = UIImage(named: "green butt.png")
        //{
        //    button.setImage(UIImage(named: "red butt.png"), for: .normal)
        //}
        let coordinates = getCoordinates(location: button.tag)
        let newValue = CurrentUser.getSchedule()[currentDay][amOrPm][coordinates.0][coordinates.1] == 0 ? 1 : 0
        let dayInString = dayIndexToString(day: currentDay)
        CurrentUser.setSchedule(day: currentDay, amOrPm: amOrPm, tuple: coordinates, value: newValue)
        ConnectionManager.updateSchedule(userName: CurrentUser.getUserName(), day: dayInString, amOrPm: amOrPm, hour: coordinates.0, min: coordinates.1, value: newValue)
    }

    @IBAction func indexChanged(sender:UISegmentedControl)
    { 
        switch sender.selectedSegmentIndex
        {
        case 0:
            amOrPm = 0
            //loadSchedule(day: currentDay, amOrPm: amOrPm)
        case 1:
            amOrPm = 1
            //loadSchedule(day: currentDay, amOrPm: amOrPm)
        default:
            break;
        }
    }
    
   // private func loadSchedule(day: Int, amOrPm: Int) {
  //     for i in 0...CurrentUser.getSchedule()[day][amOrPm].count-1 {
    //        for j in 0...CurrentUser.getSchedule()[day][amOrPm][i].count-1 {
      //          schedule2Darray[j][i].backgroundColor = CurrentUser.getSchedule()[day][amOrPm][i][j] == 0 ? UIColor.blue : UIColor.red
      //      }
     //   }
   // }
    
    private func getCoordinates(location:Int) -> (Int, Int) {
        print(location)
        if (location < 24) {
            return ((location%6), (location/6))
        } else {
            return ((location%6)+6, (location/6)-4)
        }
    }
    
    private func dayIndexToString(day: Int) -> String {
        switch day {
        case 0:
            return "Sun"
        case 1:
            return "Mon"
        case 2:
            return "Tues"
        case 3:
            return "Wed"
        case 4:
            return "Thur"
        case 5:
            return "Fri"
        case 6:
            return "Sat"
        default:
            return ""
        }
    }
    
    private func updateDayLabel(day: Int) {
        switch day {
        case 0:
            dayLabel.text = "Sunday"
        case 1:
            dayLabel.text = "Monday"
        case 2:
            dayLabel.text = "Tuesday"
        case 3:
            dayLabel.text = "Wednesday"
        case 4:
            dayLabel.text = "Thursday"
        case 5:
            dayLabel.text = "Friday"
        case 6:
            dayLabel.text = "Saturday"
        default: break
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
