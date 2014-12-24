//
//  MapVC.swift
//  CS392Project
//
//  Created by student4 on 24/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit

class MapVC: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  var userToLocate: [String: String]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.activityIndicator.startAnimating()
    self.activityIndicator.hidden = true
  }
  
}