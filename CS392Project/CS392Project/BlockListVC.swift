//
//  BlockListVC.swift
//  CS392Project
//
//  Created by student4 on 12/01/15.
//  Copyright (c) 2015 student4. All rights reserved.
//

import UIKit

class BlockListVC: UITableViewController {
  
  var blockedContacts: [[String: String]]! = [
    ["firstname":"Umut", "lastname":"Uzgur", "username":"umutuzgur", "status":"offline"],
    ["firstname":"Yunus", "lastname":"Yilmaz", "username":"yunusyilmaz", "status":"offline"],
    ["firstname":"Emre", "lastname":"Unal", "username":"emreunal", "status":"offline"]
  ]
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if blockedContacts == nil {
      return 0
    }
    
    return blockedContacts.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("blockedCell") as UITableViewCell
    if let user = getUser(indexPath) {
      cell.textLabel?.text = user
    } else {
      NSLog("A problem occurred while getting user from contacts, most probably it is blocked..")
    }
    
    return cell
  }
  
  private func getUser(indexPath: NSIndexPath) -> String? {
    let user = self.blockedContacts[indexPath.item]
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
  
  override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    var blockAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Unblock") { (blockAction, indexPath) -> Void in
      self.unblockUser(indexPath)
    }
    
    var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (deleteAction, indexPath) -> Void in
      self.deleteUser(indexPath)
    }
    
    return [blockAction, deleteAction]
  }
  
  private func unblockUser(indexPath: NSIndexPath) {
    let myTabBarController = self.tabBarController as MyTabBarController
    let user = myTabBarController.user
    let userToBlock = self.blockedContacts[indexPath.item]
    NSLog("[\"request\":\"unblockUser\", \"requester\":\"" + user["username"]! + "\", \"requested\":\"" + userToBlock["username"]! + "\"]")
    blockedContacts.removeAtIndex(indexPath.item)
    self.tableView.reloadData()
  }
  
  private func deleteUser(indexPath: NSIndexPath) {
    let myTabBarController = self.tabBarController as MyTabBarController
    let user = myTabBarController.user
    let userToDelete = self.blockedContacts[indexPath.item]
    NSLog("[\"request\":\"deleteUser\", \"requester\":\"" + user["username"]! + "\", \"requested\":\"" + userToDelete["username"]! + "\"]")
    blockedContacts.removeAtIndex(indexPath.item)
    self.tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchBlockedContacts()
  }
  
  private func fetchBlockedContacts() {
    // assume it is fetched
    blockedContacts = [
      ["firstname":"Umut", "lastname":"Uzgur", "username":"umutuzgur", "status":"offline"],
      ["firstname":"Yunus", "lastname":"Yilmaz", "username":"yunusyilmaz", "status":"offline"],
      ["firstname":"Emre", "lastname":"Unal", "username":"emreunal", "status":"offline"]
    ]
  }
  
}
