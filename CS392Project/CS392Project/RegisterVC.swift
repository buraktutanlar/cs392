//
//  RegisterVC.swift
//  CS392Project
//
//  Created by student4 on 20/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
  
  var tempPhoneNumber: String!
  @IBOutlet weak var phoneNumberField: UITextField!
  @IBOutlet weak var firstNameField: UITextField!
  @IBOutlet weak var lastNameField: UITextField!
  @IBOutlet weak var registerButton: UIButton!
  
  @IBAction func textChanged(sender: AnyObject) {
    if self.firstNameField.text != "" && self.lastNameField.text != "" {
      self.registerButton.enabled = true
    } else {
      self.registerButton.enabled = false
    }
  }
  
  @IBAction func register(sender: AnyObject) {
    let result = self.registerUser(self.firstNameField.text, lastName: self.lastNameField.text, phoneNumber: self.phoneNumberField.text)
    if !result {
      NSLog("A problem occurred while registering user")
    } else {
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  private func registerUser(firstName: String, lastName: String, phoneNumber: String) -> Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.phoneNumberField.placeholder = self.tempPhoneNumber
  }
  
}
