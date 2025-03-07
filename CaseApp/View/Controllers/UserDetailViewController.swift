//
//  UserDetailViewController.swift
//  CaseApp
//
//  Created by Unica Fintech on 7.03.2025.
//

import UIKit
import MapKit

final class UserDetailViewController: UIViewController {

    @IBOutlet var userInitialView: UIView!
    @IBOutlet var userInitials: UILabel!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var email: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var website: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    var user:User!
    var userColor:UIColor!
    
    let userListViewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To make circler image
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: userInitialView.bounds).cgPath
        self.userInitialView.layer.mask = maskLayer
        
    }
  
    @IBAction func backButtonDidClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUser(user:UserDetailWrapper) {
        
        self.user = user.user
        self.userColor = user.color
        prepareUI()
    }
    
    func prepareUI() {
        
        DispatchQueue.main.async {
            self.name.text = self.user.name
            self.userName.text = self.user.username
            self.email.text = self.user.email
            self.phone.text = self.user.phone
            self.website.text = self.user.website
            self.userInitials.text = self.userListViewModel.getInitials(name: self.user.name)
            self.userInitialView.backgroundColor = self.userColor
            
            self.prepareMap()
        }
        
    }
    
    
    func prepareMap() {
                
        let location = CLLocation(latitude: CLLocationDegrees(floatLiteral: Double(user.address.geo.lat) ?? 0.0), longitude: Double(user.address.geo.lng) ?? 0.0)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        
        //pin the location
        mapView.addAnnotation(annotation)
        
        //center the location
        mapView.centerToLocation(location: location)
    }
    
    
}
