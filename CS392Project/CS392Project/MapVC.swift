//
//  MapVC.swift
//  CS392Project
//
//  Created by student4 on 24/12/14.
//  Copyright (c) 2014 student4. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  var user: [String: String]!
  var userToLocate: [String: String]!
  var location: CLLocationCoordinate2D!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fetchUserLocation()
    self.setAnnotationToMapView()
  }
  
  private func fetchUserLocation() {
    NSLog("[\"request\":\"getLocation\", \"requester\":\"" + self.user["username"]! + "\", \"requested\":\"" + self.userToLocate["username"]! + "\"]")
    
    // Assume it is fetched
    self.location = CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402)
  }
  
  // This code is taken from this link before modified: http://www.ioscreator.com/tutorials/mapkit-tutorial-swift-ios8
  private func setAnnotationToMapView() {
    let span = MKCoordinateSpanMake(0.05, 0.05)
    let region = MKCoordinateRegion(center: location, span: span)
    
    mapView.setRegion(region, animated: true)
    
    let annotation = MKPointAnnotation()
    annotation.setCoordinate(self.location)
    annotation.title = userToLocate["firstname"]! + " " + userToLocate["lastname"]!
    
    mapView.addAnnotation(annotation)
  }
  
}