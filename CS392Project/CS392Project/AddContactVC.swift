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
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    self.activityIndicator.startAnimating()
    if let json = self.search(searchBar.text) {
      if let firstname = json["firstname"] {
        if let lastname = json["lastname"] {
          foundAccount.text = firstname + " " + lastname
          if let relation = getRelation(json) {
            actionButton.titleLabel?.text = relation
          } else {
            NSLog("A problem occurred about search results' status")
            return
          }
          self.activityIndicator.stopAnimating()
          resultView.hidden = false
          return
        }
      }
    }
    
    NSLog("A problem occurred while searching a username")
  }
  
//  private func getFirstName(json: [String: String]) -> String? {return nil}
  
  private func search(username: String) -> [String: String]? {
    return ["firstname":"Burak", "lastname":"Tutanlar", "relation":"Already friend"]
  }
  
  private func getRelation(json: [String: String]) -> String? {
    if let relation = json["relation"] {
      if relation == "Indifferent" {
        return "Add"
      } else {
        return relation
      }
    }
    return nil
  }
}
