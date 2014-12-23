//
//  ContactsTableVC.swift
//  CS392Project
//
//  Created by student4 on 21/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class ContactsTableVC: UITableViewController {
  
  var contacts: [[String: String]]!
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if contacts == nil {
      return 0
    }
    return contacts.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("contactCell") as ContactCell
    if let user = getUser(indexPath) {
      cell.label.text = user
    } else {
      NSLog("A problem occurred while getting user from contacts!")
    }
    
    cell.statusImg.image = getStatusImage(indexPath)
    
    return cell
  }
  
  private func getUser(indexPath: NSIndexPath) -> String? {
    let user = self.contacts[indexPath.item]
    if let firstname = user["firstname"] {
      if let lastname = user["lastname"] {
        return firstname + " " + lastname
      } else {
        NSLog("\"lastname\" key is not provided in user!")
      }
    } else {
      NSLog("\"firstname\" key is not provided in user!")
    }
    
    return nil
  }
  
  private func getStatusImage(indexPath: NSIndexPath) -> UIImage {
    if isUserOnline(indexPath) {
      return UIImage(contentsOfFile: "online")
    } else {
      return UIImage(contentsOfFile: "offline")
    }
  }
  
  private func isUserOnline(indexPath: NSIndexPath) -> Bool {
    let user = self.contacts[indexPath.item]
    if let status = user["status"] {
      if status == "online" {
        return true
      } else {
        return false
      }
    } else {
      NSLog("\"status\" key is not provided in user!")
      return false
    }
  }
  
  @IBAction func addButtonTapped(sender: AnyObject) {
    performSegueWithIdentifier("addContact", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "addContact" {
      let addContactVC = segue.destinationViewController as AddContactVC
      let myTabBarController = self.tabBarController as MyTabBarController
      addContactVC.user = myTabBarController.user
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchContacts()
  }
  
  private func fetchContacts() {
    // assume it is fetched
    contacts = [["firstname":"Deniz", "lastname":"Sokmen", "username":"denizsokmen", "status":"online"], ["firstname":"Ugur", "lastname":"Ozkan", "username":"ugurozkan", "status":"offline"], ["firstname":"Arman", "lastname":"Garip", "username":"armangarip", "status":"online"], ["firstname":"Osman", "lastname":"Sekerlen", "username":"osmansekerlen", "status":"offline"]]
  }
}
