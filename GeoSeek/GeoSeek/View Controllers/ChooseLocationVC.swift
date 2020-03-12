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
}

class ChooseLocationVC: UIViewController {
    let containerView = MGLMapView()
    var locationManager: CLLocationManager? // This should come in from the coordinator
    let doneButton = UIButton() // TODO: Make a custom button that we use throughout the app
    let titleLabel = UILabel() // TODO: Make a custom label that we use throughout the app, this label can take a String and assign it's text property, then none of the configuration would need to be done here except for the constraints.
    //    weak var coordinator: BaseCoordinator?
    weak var coordinator: CreateGemCoordinator?
    var userLocation: CLLocationCoordinate2D?
    var delegate: SetLocationDelegate?
    let darkBlueMap = URL(string: "mapbox://styles/geoseek/ck7b5gau8002g1ip7b81etzj4")
    var point = MGLPointAnnotation()
    var pressedLocation:CLLocation? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear // (red: 0, green: 0, blue: 0, alpha: 0.6)
        configureContainerView()
        configureDoneButton()
        configureTitleLabel()
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            //When lognpress is start or running
        }
        else {
            let touchPoint = gestureReconizer.location(in: containerView)
            let coordsFromTouchPoint = containerView.convert(touchPoint, toCoordinateFrom: containerView)
            
            removeAnnotation(point: point)
            
            pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
            
            guard let pressedLocation = pressedLocation else { return }
     
            point.coordinate = pressedLocation.coordinate
            
            containerView.addAnnotation(point)
            
            coordinator?.gemLat = pressedLocation.coordinate.latitude
            coordinator?.gemLong = pressedLocation.coordinate.longitude
            
            enableDoneButton()
            // myWaypoints.append(location)
            print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)
        }
    }
    
    func removeAnnotation(point: MGLPointAnnotation) {
        containerView.removeAnnotation(point)
    }
    
    func configureLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        configureMap()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        containerView.layer.cornerRadius = 30
        containerView.layer.cornerCurve = .continuous
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = false
        containerView.addGestureRecognizer(lpgr)
    }
    
    func configureMap() {
        containerView.styleURL = darkBlueMap
        guard let userLocation = locationManager?.location else {
            containerView.setCenter(CLLocationCoordinate2D(latitude: 0, longitude: 0), zoomLevel: 2, animated: false)
            return
        }
        containerView.setCenter(userLocation.coordinate, zoomLevel: 15, animated: false)
    }
    
    func configureDoneButton() {
        containerView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.isEnabled = false
        doneButton.backgroundColor = .systemGray
        doneButton.layer.cornerRadius = 5
        doneButton.layer.cornerCurve = .continuous
        doneButton.setTitle("Continue", for: .normal)
        doneButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            doneButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 120),
            doneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -120),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func enableDoneButton() {
        doneButton.isEnabled = true
        doneButton.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.2509803922, blue: 0.462745098, alpha: 1)
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .lightGray
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.cornerCurve = .continuous
        titleLabel.layer.masksToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.text = "Create a Spot"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    @objc func dismissVC() {
        guard let pressedLocation = pressedLocation else { return }
        self.delegate?.didSetLocation(to: pressedLocation.coordinate)
        
        self.dismiss(animated: true, completion: nil)
        self.coordinator?.toCreateGemVC()
    }
}

extension ChooseLocationVC: CLLocationManagerDelegate {
    
}
