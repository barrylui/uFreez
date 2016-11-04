//
//  SignUpViewController.swift
//  uFree
//
//  Created by Omer Winrauke on 10/30/16.
//  Copyright © 2016 Omer Winrauke. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passWordTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var issueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField!.delegate = self
        userNameTextField!.delegate = self
        passWordTextField!.delegate = self
        phoneNumberTextField!.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonClicked(button: UIButton) {
        // need to check if current user exits 
        // need to call async task to insure user is on DB 
        
        if (nameTextField.text != "" && userNameTextField.text != "" && passWordTextField.text != "" && phoneNumberTextField.text != "") {
            CurrentUser.sanitizeFields()
            CurrentUser.initializeUser(name: nameTextField.text!, userName: userNameTextField.text!, passWord: passWordTextField.text!, phoneNumber: phoneNumberTextField.text!)
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "sw_reveal")
            ConnectionManager.createUser(userName: CurrentUser.getUserName(), password: CurrentUser.getPassWord(), telephone: CurrentUser.getPhoneNumber(), name: CurrentUser.getNameForAsync(), view: self)
            self.present(controller!, animated: true, completion: nil)
        } else {
            issueLabel.text = "Not all the fields were filled!" 
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
