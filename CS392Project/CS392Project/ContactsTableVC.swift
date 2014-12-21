//
//  ContactsTableVC.swift
//  CS392Project
//
//  Created by student4 on 21/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class ContactsTableVC: UITableViewController {
  
  @IBAction func addButtonTapped(sender: AnyObject) {
    performSegueWithIdentifier("addContact", sender: self)
  }
}
