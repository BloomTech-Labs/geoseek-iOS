//
//  MapXib.swift
//  GeoSeek
//
//  Created by Jerry haaser on 2/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class MapXib: UIView, Storyboarded {

    @IBOutlet var mapView: MGLMapView!
    
    weak var coordinator: MainCoordinator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "MapXib", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(mapView)
        mapView.frame = self.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
        var pressedLocation:CLLocation? = nil {
            didSet{
    //                continueButton.isEnabled = true
                print("pressedLocation was set")
            }
        }
    
        @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
            if gestureReconizer.state != UIGestureRecognizer.State.ended {
            } else {
                print("I was long pressed...")
    
                mapView.setCenter(CLLocationCoordinate2D(latitude: 33.812794, longitude: -117.9190981), zoomLevel: 15, animated: false)
                let touchPoint = gestureReconizer.location(in: mapView)
                let coordsFromTouchPoint = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
                print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)
    
                let wayAnnotation = MGLPointAnnotation()
                wayAnnotation.coordinate = coordsFromTouchPoint
                wayAnnotation.title = "waypoint"
    
            }
        }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
