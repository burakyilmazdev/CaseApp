//
//  MKMapView+Extension.swift
//  CaseApp
//
//  Created by Unica Fintech on 7.03.2025.
//

import Foundation
import MapKit

extension MKMapView {
    
  func centerToLocation(location: CLLocation,regionRadius: CLLocationDistance = 1000) {
      
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
      
  }
}
