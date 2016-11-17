//
//  ViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/29/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var userNameTextField: UITextField?
    @IBOutlet var passWordTextField: UITextField?
    
    private let LOGIN_SEGUE_NAME = "login_segue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField!.delegate = self
        passWordTextField!.delegate = self
        


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if (isUserDataStores()) {
            print("user data was stored")
            ConnectionManager.loginUser(userName: defaults.string(forKey: "UserName")!
                , passWord: (defaults.string(forKey: "Password"))!, view: self)
            ConnectionManager.setDeviceToken(userName: (userNameTextField?.text!)!, token: CurrentUser.getDeviceToken())
            //            let controller = self.storyboard?.instantiateViewController(withIdentifier: "sw_reveal")
            //            self.present(controller!, animated: true, completion: nil)
        } else {
            print("user data isnt stored")
            ConnectionManager.setDeviceToken(userName: (userNameTextField?.text!)!, token: CurrentUser.getDeviceToken())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonClicked(button: UIButton) {
        let internetCheck = Reachability()
        if (internetCheck.isInternetAvailable()) {

            ConnectionManager.loginUser(userName: (userNameTextField?.text!)!, passWord: (passWordTextField?.text!)!, view: self)
            ConnectionManager.setDeviceToken(userName: (userNameTextField?.text!)!, token: CurrentUser.getDeviceToken())
        } else {
            let alert = UIAlertController(title: "Error!", message: "No Internet connection available", preferredStyle: .alert)
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func isUserDataStores() -> Bool {
        let defaults = UserDefaults.standard
        return !(defaults.string(forKey: "UserName") == nil) && !(defaults.string(forKey: "Password") == nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return !prospectiveText.contains(" ")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        print(CurrentUser.isUserInitialized())
//        if (LOGIN_SEGUE_NAME == identifier && !CurrentUser.isUserInitialized()) {
//            return false
//        }
//        return true
//    }
    
 

}

