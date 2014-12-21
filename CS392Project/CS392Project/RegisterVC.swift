//
//  RegisterVC.swift
//  CS392Project
//
//  Created by student4 on 20/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
  
  @IBOutlet weak var firstNameField: UITextField!
  @IBOutlet weak var lastNameField: UITextField!
  @IBOutlet weak var userNameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var repeatPasswordField: UITextField!
  @IBOutlet weak var doneButton: UIBarButtonItem!
  
  @IBAction func textChanged(sender: AnyObject) {
    if self.firstNameField.text != ""
      && self.lastNameField.text != ""
      && self.userNameField.text != ""
      && self.emailField.text != ""
      && self.passwordField.text != ""
      && self.repeatPasswordField.text != "" {
      self.doneButton.enabled = true
    } else {
      self.doneButton.enabled = false
    }
  }
  
  @IBAction func cancelTapped(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func register(sender: AnyObject) {
    if !isPasswordsMatched() {
      warn("Passwords not matched!")
      return
    }
    
    if !isEmailValid() {
      warn("Email address is invalid!")
      return
    }
    
    let result = self.registerUser(self.firstNameField.text, lastName: self.lastNameField.text, userName: self.userNameField.text, email: self.emailField.text, password: self.passwordField.text)
    
    if !result {
      NSLog("A problem occurred while registering user")
    } else {
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  private func isPasswordsMatched() -> Bool {
    return self.passwordField.text == self.repeatPasswordField.text
  }
  
  // This function is taken from this link:
  // http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
  private func warn(message: String) {
    let popup = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    popup.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(popup, animated: true, completion: nil)
  }
  
  private func isEmailValid() -> Bool {
    let email = self.emailField.text
    if countElements(email) > 512 {
      return false
    }
    
    return true
  }
  
  private func registerUser(firstName: String, lastName: String, userName: String, email: String, password: String) -> Bool {
    return true
  }
  
}
