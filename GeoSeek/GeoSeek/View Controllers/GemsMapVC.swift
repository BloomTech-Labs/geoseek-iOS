//
//  ViewController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 2/20/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class GemsMapVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var customTabBarXib: CustomTabBarXib!
    @IBOutlet weak var mapView: MGLMapView!
    
    
    var coordinator: GemsMapCoordinator?
    var delegate: GemsMapCoordinatorDelegate?
    var gemController: GemController?
    var userLocation: CLLocationCoordinate2D?
    let darkBlueMap = URL(string: "mapbox://styles/geoseek/ck7b5gau8002g1ip7b81etzj4")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabBarXib.delegate = delegate
        NetworkController.shared.fetchGems { result in
            switch result {
            case .failure(let error):
                print("Error fetching Gems: \(error)")
            case .success(let gems):
                self.gemController?.gems = gems
                DispatchQueue.main.async {
                    self.configureMapView()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureMapView()
    }
    
    func configureMapView() {
        
        var pointAnnotations: [MGLPointAnnotation] = []
        
        let userPoint = MGLPointAnnotation()
        
        if let userLocation = userLocation {
            userPoint.coordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
            pointAnnotations.append(userPoint)
            mapView.setCenter(userLocation, zoomLevel: 15, animated: false)
        } else {
            mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
        }
        
        mapView.styleURL = darkBlueMap
        mapView.delegate = self
        
        guard let gemController = gemController else { return }
        
        for gem in gemController.gems {
            print(gem.title ?? "No Title", gem.latitude, gem.longitude)
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
}

extension GemsMapVC: MGLMapViewDelegate {
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
