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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonClicked(button: UIButton) {
        ConnectionManager.loginUser(userName: (userNameTextField?.text!)!, passWord: (passWordTextField?.text!)!, view: self)
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

