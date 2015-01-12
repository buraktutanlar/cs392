//
//  AddContactVC.swift
//  CS392Project
//
//  Created by student4 on 21/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class AddContactVC: UIViewController, UISearchBarDelegate {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var resultView: UIView!
  @IBOutlet weak var foundAccount: UILabel!
  @IBOutlet weak var actionButton: UIButton!
  
  var searchedUserJSON: [String: String]?
  var user: [String: String]!
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    self.resultView.hidden = true
    self.activityIndicator.startAnimating()
    self.activityIndicator.hidden = false
    if let json = self.search(searchBar.text) {
      self.searchedUserJSON = json
      if let firstname = json["firstname"] {
        if let lastname = json["lastname"] {
          foundAccount.text = firstname + " " + lastname
          setActionButtonTitle(json)
          resultView.hidden = false
          self.activityIndicator.hidden = true
          self.activityIndicator.stopAnimating()
          return
        }
      }
    }
    
    NSLog("A problem occurred while searching a username")
  }
  
  @IBAction func actionButtonTapped(sender: AnyObject) {
    let title = self.actionButton.titleForState(UIControlState.Normal)
    if title == "Add" {
      sendRequestToAddUser()
    } else if title == "Already friend" {
      askToDeleteUser()
    } else if title == "Requested" {
      askToCancelRequest()
    }
  }
  
  // This function is taken from this link:
  // http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
  private func ask(message: String, function: (UIAlertAction!) -> ()) {
    let popup = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    popup.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
    popup.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: function))
    self.presentViewController(popup, animated: true, completion: nil)
  }
  
  private func sendRequestToAddUser() {
    // assume it is sent
    if let requested = self.searchedUserJSON {
      self.actionButton.setTitle("Requested", forState: UIControlState.Normal)
      NSLog("[\"request\":\"addUser\", \"requester\":" + user.description + ", \"requested\":" + requested.description + "]")
    } else {
      NSLog("No searched user to send request to add!")
    }
  }
  
  private func askToDeleteUser() {
    ask("Do you want to delete this user?", function: { (UIAlertAction) -> () in
      self.deleteUser()
    })
  }
  
  private func deleteUser() {
    // assume it is deleted
    if let requested = self.searchedUserJSON {
      self.actionButton.setTitle("Add", forState: UIControlState.Normal)
      NSLog("[\"request\":\"deleteUser\", \"requester\":" + self.user.description + ", \"requested\":" + requested.description + "]")
    } else {
      NSLog("No searched user to send request to delete!")
    }
  }
  
  private func askToCancelRequest() {
    ask("Do you want to cancel your request?", function: { (UIAlertAction) -> () in
      self.cancelRequest()
    })
  }
  
  private func cancelRequest() {
    // assume it is canceled
    if let requested = searchedUserJSON {
      self.actionButton.setTitle("Add", forState: UIControlState.Normal)
      NSLog("[\"request\":\"cancelRequest\", \"requester\":" + self.user.description + ", \"requested\":" + requested.description + "]")
    } else {
      NSLog("No searched user to cancel invitation!")
    }
  }
  
  private func search(username: String) -> [String: String]? {
    // this is a dummy response
    NSLog("[\"request\":\"searchUser\", \"requested\":\"" + username + "\"]")
    return ["firstname":"Burak", "lastname":"Tutanlar", "relation":"Already friend"]
  }
  
  private func setActionButtonTitle(json: [String: String]) {
    if let relation = json["relation"] {
      if relation == "Indifferent" {
        actionButton.setTitle("Add", forState: UIControlState.Normal)
      } else {
        actionButton.setTitle(relation, forState: UIControlState.Normal)
      }
    } else {
      NSLog("relation key is not found!")
    }
  }
}
