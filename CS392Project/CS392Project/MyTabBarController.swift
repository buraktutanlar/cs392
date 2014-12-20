//
//  MyTabBarController.swift
//  CS392Project
//
//  Created by student4 on 20/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
  
  var userPhoneNumber: String!
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    if let userPhoneNumber = getUserPhoneNumber() {
      self.userPhoneNumber = userPhoneNumber
      if !isPhoneNumberRegistered() {
        performSegueWithIdentifier("register", sender: self)
      }
    } else {
      NSLog("A problem occurred while getting user's phone number!")
    }
  }
  
  private func getUserPhoneNumber() -> String? {
    return "amcik"
  }
  
  private func isPhoneNumberRegistered() -> Bool {
    return true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "register" {
      let registerVC = segue.destinationViewController as RegisterVC
      registerVC.tempPhoneNumber = self.userPhoneNumber
    }
  }
  
}
