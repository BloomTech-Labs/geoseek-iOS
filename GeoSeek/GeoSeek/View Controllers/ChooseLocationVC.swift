//
//  GSMapViewControlle.swift
//  GeoSeek
//
//  Created by Jerry haaser on 3/3/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Mapbox
import UIKit

protocol SetLocationDelegate {
    func didSetLocation(to location: CLLocationCoordinate2D)
    func toCreateGemVC()
}

class ChooseLocationVC: UIViewController {
    
    let viewContainer = UIView()
    let mapView = MGLMapView()
    var locationManager: CLLocationManager?
    let doneButton = UIButton()
    let titleLabel = UILabel()
    
    weak var coordinator: BaseCoordinator?
    var userLocation: CLLocationCoordinate2D?
    var delegate: SetLocationDelegate?
    let darkBlueMap = URL(string: "mapbox://styles/geoseek/ck7b5gau8002g1ip7b81etzj4")!
    var point = MGLPointAnnotation()
    var pressedLocation:CLLocation? = nil
    var gemController: GemController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        configureContainerView()
        configureDoneButton()
        configureTitleLabel()
        configureMapView()
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            //When lognpress is start or running
        }
        else {
            let touchPoint = gestureReconizer.location(in: mapView)
            let coordsFromTouchPoint = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            removeAnnotation(point: point)
            
            pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
            guard let pressedLocation = pressedLocation else { return }
            point.coordinate = pressedLocation.coordinate
            
            mapView.addAnnotation(point)
            
            enableDoneButton()
            print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)
        }
    }
    
    func removeAnnotation(point: MGLPointAnnotation) {
        mapView.removeAnnotation(point)
    }
    
    func configureLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func configureContainerView() {
        
        view.addSubview(viewContainer)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.2509803922, blue: 0.462745098, alpha: 1)
        viewContainer.layer.cornerRadius = 30
        viewContainer.layer.cornerCurve = .continuous
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 114),
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(mapView)
        configureMap()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        mapView.layer.cornerRadius = 30
        mapView.layer.cornerCurve = .continuous
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.1
        lpgr.delaysTouchesBegan = false
        mapView.addGestureRecognizer(lpgr)
    }
    
    func configureMap() {
        mapView.styleURL = darkBlueMap
        guard let userLocation = locationManager?.location else {
            print("No location")
            mapView.setCenter(CLLocationCoordinate2D(latitude: 0, longitude: 0), zoomLevel: 2, animated: false)
            return
        }
        print("Have a location")
        mapView.setCenter(userLocation.coordinate, zoomLevel: 15, animated: false)
    }
    
    func configureDoneButton() {
        mapView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.isEnabled = false
        doneButton.backgroundColor = .systemGray
        doneButton.layer.cornerRadius = 5
        doneButton.layer.cornerCurve = .continuous
        doneButton.setTitle("Continue", for: .normal)
        doneButton.addTarget(self, action: #selector(dismissVC), for: .touchDown)
        
        
        NSLayoutConstraint.activate ([
            doneButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -40),
            doneButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 120),
            doneButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -120),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func enableDoneButton() {
        doneButton.isEnabled = true
        doneButton.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.2509803922, blue: 0.462745098, alpha: 1)
    }
    
    func configureTitleLabel() {
        mapView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .clear
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.cornerCurve = .continuous
        titleLabel.layer.masksToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = "Tap the map to select a location."
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    @objc func dismissVC() {
        guard let pressedLocation = pressedLocation else { return }
        self.delegate?.didSetLocation(to: pressedLocation.coordinate)
        
        self.dismiss(animated: true, completion: nil)
        delegate?.toCreateGemVC()
    }
    
    func configureMapView() {
        mapView.delegate = self
        mapView.configure(mapStyle: darkBlueMap, locationManager: locationManager, gemController: gemController)
    }
}

extension ChooseLocationVC: CLLocationManagerDelegate {
    
}

extension ChooseLocationVC: MGLMapViewDelegate {
    
    func mapView(_ containerView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ containerView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        let imageName = "blueGem"
        
        // Use the image name as the reuse identifier for its view.
        let reuseIdentifier = imageName
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = containerView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier, image: UIImage(named: imageName)!)
        }
        return annotationView
    }
}
