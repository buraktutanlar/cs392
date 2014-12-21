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
    if !login() {
      performSegueWithIdentifier("login", sender: self)
    }
  }
  
  private func login() -> Bool {
    if let userName = getUserName() {
      if let password = getPassword() {
        if login(userName, password: password) {
          return true
        }
      }
    }
    
    return false
  }
  
  // To be implemented..
  private func getUserName() -> String? {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    if let username: AnyObject = userDefaults.objectForKey("username") {
      return username as? String
    }
    return nil
  }
  
  // To be implemented..
  private func getPassword() -> String? {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    if let password: AnyObject = userDefaults.objectForKey("password") {
      return password as? String
    }
    return nil
  }
  
  // To be implemented..
  private func login(userName: String, password: String) -> Bool {
    return true
  }
  
}
