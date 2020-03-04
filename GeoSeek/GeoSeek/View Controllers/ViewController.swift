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
    
    @IBOutlet weak var customTabBarXib: CustomTabBarXib!
    @IBOutlet weak var mapView: MGLMapView!
    
    
    weak var coordinator: MainCoordinator?
    var gems: [Gem] = []
    
    var pressedLocation:CLLocation? = nil {
        didSet{
            //                continueButton.isEnabled = true
            print("pressedLocation was set")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBarXib.coordinator = coordinator
//        mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
        fetchGems()
    }
    
    func fetchGems() {
        NetworkController.shared.fetchGems { result in
            switch result {
            case .failure(let error):
                print("ViewController.fetchGems Error: \(error)")
            case .success(let gems):
                self.gems = gems
                DispatchQueue.main.async {
                    self.configureMapView()
                }
            }
        }
    }
    
    let darkBlueMap = URL(string: "mapbox://styles/geoseek/ck7b5gau8002g1ip7b81etzj4")
    
    
    func configureMapView() {
//        mapView.styleURL = MGLStyle.outdoorsStyleURL
        mapView.styleURL = darkBlueMap
//        mapView.tintColor = .darkGray
        mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
//        mapView.zoomLevel = 3
        mapView.delegate = self
        
        var pointAnnotations: [MGLPointAnnotation] = []
        for gem in gems {
            if gem.latitude > 90 || gem.latitude < -90 || gem.longitude > 180 || gem.longitude < -180 {
                print(gem.description)
                continue
            }
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: gem.latitude, longitude: gem.longitude)
            point.title = "\(gem.title ?? "No Title")"
            pointAnnotations.append(point)
        }
        mapView.addAnnotations(pointAnnotations)
    }
    
    //        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStyleURL)
    //        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //        mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
    
    //        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
    //        lpgr.minimumPressDuration = 0.5
    //        lpgr.delaysTouchesBegan = false
    //        mapView.addGestureRecognizer(lpgr)
    
    // view.addSubview(mapView)
}

//    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
//        if gestureReconizer.state != UIGestureRecognizer.State.ended {
//        } else {
//            print("I was long pressed...")
//
//            myMapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
//            let touchPoint = gestureReconizer.location(in: myMapView)
//            let coordsFromTouchPoint = myMapView.convert(touchPoint, toCoordinateFrom: myMapView)
//            pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
//            print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)
//
//            let wayAnnotation = MGLPointAnnotation()
//            wayAnnotation.coordinate = coordsFromTouchPoint
//            wayAnnotation.title = "waypoint"
//
//        }
//    }




extension ViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else { return nil }
        
        let reuseIdentifier = "\(annotation.coordinate.latitude)\(annotation.coordinate.longitude)"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        let hue = CGFloat((abs(Double(annotation.coordinate.longitude).rounded())) / 90)
        let annotationColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView?.backgroundColor = annotationColor
            annotationView?.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
