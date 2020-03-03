//
//  GSMapViewControlle.swift
//  GeoSeek
//
//  Created by Jerry haaser on 3/3/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Mapbox
import UIKit

class GSMapViewController: UIViewController {
    let containerView = MGLMapView() // This should come in from the coordinator
    let locationManager = CLLocationManager() // This should come in from the coordinator
    let doneButton = UIButton() // TODO: Make a custom button that we use throughout the app
    let titleLabel = UILabel() // TODO: Make a custom label that we use throughout the app, this label can take a String and assign it's text property, then none of the configuration would need to be done here except for the constraints.
    weak var coordinator: MainCoordinator?
    
    var pressedLocation:CLLocation? = nil {
        didSet{
            //            continueButton.isEnabled = true
            //            continueButton.isHighlighted = true
            print("pressedLocation was set")
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        configureContainerView()
        configureDoneButton()
        configureTitleLabel()
    }
    func configureLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        containerView.layer.cornerRadius = 30
        containerView.layer.cornerCurve = .continuous
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = false
        containerView.addGestureRecognizer(lpgr)
    }
    func configureDoneButton() {
        containerView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = .systemYellow
        doneButton.layer.cornerRadius = 5
        doneButton.layer.cornerCurve = .continuous
        doneButton.setTitle("This is it!", for: .normal)
        doneButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            doneButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 120),
            doneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -120),
            doneButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            //When lognpress is start or running
        }
        else {
            print("I was long pressed...")
            
            let touchPoint = gestureReconizer.location(in: containerView)
            let coordsFromTouchPoint = containerView.convert(touchPoint, toCoordinateFrom: containerView)
            pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
            // myWaypoints.append(location)
            print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)
            
            //            let wayAnnotation = MKPointAnnotation()
            //            wayAnnotation.coordinate = coordsFromTouchPoint
            //            wayAnnotation.title = "waypoint"
            //            myAnnotations.append(location)
            //            print(wayAnnotation)
            
            let alert = UIAlertController(title: "Add Location?", message: "Would you like this to be your chosen location?", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Continue", style: .default) { (_) in
                //                func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                //                    if segue.identifier == "ToAddSegue" {
                //                        let destinationVC = segue.destination as? AddViewController
                //                        destinationVC?.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
                //                    }
                //                }
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(cancel)
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
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
        dismiss(animated: true)
    }
}
extension GSMapViewController: CLLocationManagerDelegate {
}
