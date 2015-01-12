//
//  ContactsTableVC.swift
//  CS392Project
//
//  Created by student4 on 21/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class ContactsTableVC: UITableViewController {
  
  @IBOutlet weak var statusSwitch: UISwitch!
  
  var contacts: [[String: String]]! = [
    ["firstname":"Deniz", "lastname":"Sokmen", "username":"denizsokmen", "status":"online"],
    ["firstname":"Ugur", "lastname":"Ozkan", "username":"ugurozkan", "status":"offline"],
    ["firstname":"Arman", "lastname":"Garip", "username":"armangarip", "status":"online"],
    ["firstname":"Osman", "lastname":"Sekerlen", "username":"osmansekerlen", "status":"offline"]
  ]
  
  @IBAction func statesSwitched(sender: AnyObject) {
    let myTabController = self.tabBarController as MyTabBarController
    let user = myTabController.user
    NSLog("[\"request\":\"setStatus\", \"requester\":\"" + user["username"]! + "\"]")
    self.tableView.reloadData()
  }
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
    let cell = self.tableView.dequeueReusableCellWithIdentifier("contactCell") as UITableViewCell
    if let user = getUser(indexPath) {
      cell.textLabel?.text = user
    } else {
      NSLog("A problem occurred while getting user from contacts, most probably it is blocked..")
    }
    
    setStatusImage(cell, indexPath: indexPath)
    
    return cell
  }
  
  override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    var blockAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Block") { (blockAction, indexPath) -> Void in
      self.blockUser(indexPath)
    }
    
    var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (deleteAction, indexPath) -> Void in
      self.deleteUser(indexPath)
    }
    
    return [blockAction, deleteAction]
  }
  
  private func blockUser(indexPath: NSIndexPath) {
    let myTabBarController = self.tabBarController as MyTabBarController
    let user = myTabBarController.user
    let userToBlock = self.contacts[indexPath.item]
    NSLog("[\"request\":\"blockUser\", \"requester\":\"" + user["username"]! + "\", \"requested\":\"" + userToBlock["username"]! + "\"]")
    contacts.removeAtIndex(indexPath.item)
    self.tableView.reloadData()
  }
  
  private func deleteUser(indexPath: NSIndexPath) {
    let myTabBarController = self.tabBarController as MyTabBarController
    let user = myTabBarController.user
    let userToDelete = self.contacts[indexPath.item]
    NSLog("[\"request\":\"deleteUser\", \"requester\":\"" + user["username"]! + "\", \"requested\":\"" + userToDelete["username"]! + "\"]")
    contacts.removeAtIndex(indexPath.item)
    self.tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}

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
  
  private func setStatusImage(cell: UITableViewCell, indexPath: NSIndexPath) {
    if isUserOnline(indexPath) && self.statusSwitch.on {
      cell.imageView?.image = UIImage(named: "online")
      cell.tag = 1
    } else {
      cell.imageView?.image = UIImage(named: "offline")
      cell.tag = 0
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
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    if identifier != "map" {
      return true
    }
    
    if let cell = sender as? UITableViewCell {
      if cell.tag == 0 {
        cell.selected = false
        return false
      }
    }
    return true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "addContact" {
      prepareForAddContact(segue)
    } else if segue.identifier == "map" {
      prepareForMap(segue, sender: sender)
    }
  }
  
  private func prepareForAddContact(segue: UIStoryboardSegue) {
    let addContactVC = segue.destinationViewController as AddContactVC
    let myTabBarController = self.tabBarController as MyTabBarController
    addContactVC.user = myTabBarController.user
  }
  
  private func prepareForMap(segue: UIStoryboardSegue, sender: AnyObject?) {
    let mapVC = segue.destinationViewController as MapVC
    if let userToLocate = sender as? UITableViewCell {
      if let indexPath = tableView.indexPathForCell(userToLocate) {
        mapVC.userToLocate = contacts[indexPath.item]
        mapVC.user = (self.tabBarController as MyTabBarController).user
        NSLog("User to be located: " + mapVC.userToLocate.description)
      } else {
        NSLog("NSIndexPath of the cell tapped!")
      }
    } else {
      NSLog("prepareForMap function is called from something other than a UITableViewCell")
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
