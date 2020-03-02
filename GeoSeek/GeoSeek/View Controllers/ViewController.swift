//
//  ViewController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/20/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var myMapView: MGLMapView!
    weak var coordinator: MainCoordinator?
    var mapView: MGLMapView!
    
    var pressedLocation:CLLocation? = nil {
        didSet{
//                continueButton.isEnabled = true
            print("pressedLocation was set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkController.shared.fetchGems { result in
            switch result {
            case .failure(let error):
                print("Oops!:", error)
            case .success(let gems):
                gems.compactMap { (print("ViewController:", $0.title)) }
            }
        }
        
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = false
        mapView.addGestureRecognizer(lpgr)
        
        view.addSubview(mapView)
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
        } else {
            print("I was long pressed...")
            
            myMapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
            let touchPoint = gestureReconizer.location(in: myMapView)
            let coordsFromTouchPoint = myMapView.convert(touchPoint, toCoordinateFrom: myMapView)
            pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
            print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)
            
            let wayAnnotation = MGLPointAnnotation()
            wayAnnotation.coordinate = coordsFromTouchPoint
            wayAnnotation.title = "waypoint"
            
        }
    }
    
    
}

