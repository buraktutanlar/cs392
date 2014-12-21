//
//  LoginVC.swift
//  CS392Project
//
//  Created by student4 on 21/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  @IBOutlet weak var userNameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var forgotButton: UIButton!
  
  
  @IBAction func textChanged(sender: AnyObject) {
    if self.userNameField.text != "" && self.passwordField.text != nil {
      self.loginButton.enabled = true
    } else {
      self.loginButton.enabled = false
    }
  }
  
  @IBAction func loginTapped(sender: AnyObject) {
    if login() {
      dismissViewControllerAnimated(true, completion: nil)
    } else {
      warn("Please try again.")
    }
  }
  
  // To be implemented..
  private func login() -> Bool {
    let userName = self.userNameField.text
    let password = self.passwordField.text
    // try to login with these credentials..
    // for now insert dummy username into NSUserDefaults
    setIntoUserDefaults(userName, password: password)
    
    return true
  }
  
  private func setIntoUserDefaults(userName: String, password: String) {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setObject(userName, forKey: "username")
    userDefaults.setObject(password, forKey: "password")
  }
  
  @IBAction func registerTapped(sender: AnyObject) {
    performSegueWithIdentifier("register", sender: self)
  }
  
  @IBAction func forgotTapped(sender: AnyObject) {
    warn("This button is not imlemented yet..")
  }
  
  // This function is taken from this link:
  // http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
  private func warn(message: String) {
    let popup = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    popup.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(popup, animated: true, completion: nil)
  }
  
}
