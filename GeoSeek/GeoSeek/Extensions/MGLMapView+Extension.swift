//
//  MGLMapView+Extension.swift
//  GeoSeek
//
//  Created by morse on 3/24/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import Mapbox

extension MGLMapView {
    
    func configure(mapStyle: URL, locationManager: CLLocationManager?, gemController: GemController?) {
        self.showsUserLocation = true
        self.styleURL = mapStyle
        setCenterLocation(gemController: gemController, locationManager: locationManager)
        
        guard let gemController = gemController else { return }
        addGemAnnotations(gemController: gemController)
        gemController.recentGem = nil
    }
    
    func setCenterLocation(gemController: GemController?, locationManager: CLLocationManager?) {
        if let recentGem = gemController?.recentGem {
            let location = CLLocationCoordinate2D(latitude: recentGem.latitude, longitude: recentGem.longitude)
            self.setCenter(location, animated: true)
        } else if let locationManager = locationManager,
            let location = locationManager.location {
            self.setCenter(location.coordinate, zoomLevel: 15, animated: false)
        } else {
            self.setCenter(CLLocationCoordinate2D(latitude: 0, longitude: 0), zoomLevel: 2, animated: false)
        }
    }
    
    func addGemAnnotations(gemController: GemController) {
        var pointAnnotations: [MGLPointAnnotation] = []
        
        for gem in gemController.gems {
            if gem.latitude > 90 || gem.latitude < -90 || gem.longitude > 180 || gem.longitude < -180 {
                print(gem.description)
                continue
            }
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: gem.latitude, longitude: gem.longitude)
            point.title = "\(gem.title ?? "No Title")"
            pointAnnotations.append(point)
            gemController.gemDictionary[point.hash] = gem
        }
        self.addAnnotations(pointAnnotations)
    }
}
