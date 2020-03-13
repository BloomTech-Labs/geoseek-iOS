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
    
    
    @IBOutlet weak var navButtonsXib: NavButtonsXib!
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
        mapView.showsUserLocation = true
        
        if let recentGem = gemController?.recentGem {
            let location = CLLocationCoordinate2D(latitude: recentGem.latitude, longitude: recentGem.longitude)
            mapView.setCenter(location, animated: true)
        } else if let userLocation = userLocation {
            mapView.setCenter(userLocation, zoomLevel: 15, animated: false)
        } else {
            mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
        }
        
        mapView.styleURL = darkBlueMap
        mapView.delegate = self
        
        guard let gemController = gemController else { return }
        
            for gem in gemController.gems {
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
            gemController.recentGem = nil
        }
        mapView.addAnnotations(pointAnnotations)
        gemController.recentGem = nil
    }
}

extension GemsMapVC: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        let imageName = "blueGem"
        
        // Use the image name as the reuse identifier for its view.
        let reuseIdentifier = imageName
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier, image: UIImage(named: imageName)!)
        }
        return annotationView
    }
}
