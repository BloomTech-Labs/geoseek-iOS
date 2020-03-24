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
    
    var coordinator: BaseCoordinator?
    var delegate: GemsMapCoordinatorDelegate?
    var gemController: GemController?
    var locationManager: CLLocationManager?
    let darkBlueMap = URL(string: "mapbox://styles/geoseek/ck7b5gau8002g1ip7b81etzj4")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabBarXib.delegate = delegate
        navButtonsXib.delegate = delegate
        
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
        mapView.delegate = self
        mapView.configure(mapStyle: darkBlueMap, locationManager: locationManager, gemController: gemController)
    }
}


extension GemsMapVC: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        // Instantiate and return our custom callout view.
        return CustomCalloutView(representedObject: annotation)
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        // Optionally handle taps on the callout.
        delegate?.showGemDetails(for: annotation)
        // Hide the callout.
        mapView.deselectAnnotation(annotation, animated: true)
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
