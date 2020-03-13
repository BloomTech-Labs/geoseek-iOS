//
//  ChooseYourLocationVC.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/9/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

enum LocationType {
    case current
    case choose
}

protocol ChooseLocationDelegate {
    
    func locationWasChosen(with type: LocationType)
}

class ChooseYourLocationVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var chooseView: UIView?
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var newLocationButton: UIButton!
    
    var delegate: ChooseLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleChooseView()
        createDismissTapGesture()
    }
    
    func createDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView(_ sender: UITapGestureRecognizer) {
        if !chooseView!.frame.contains(sender.location(in: self.view)) {
            dismiss(animated: true)
        }
    }
    
    
    func styleChooseView() {
        chooseView?.layer.cornerRadius = 20.0
        chooseView?.clipsToBounds = true
        
        currentLocationButton.layer.cornerRadius = 4
        currentLocationButton.clipsToBounds = true
        
        newLocationButton.layer.cornerRadius = 4
        newLocationButton.clipsToBounds = true
    }
    
    @IBAction func currentLocationTapped(_ sender: Any) {
        passLocationType(.current)
        print("Current Location Button Tapped...")
    }
    
    @IBAction func newLocationTapped(_ sender: Any) {
        passLocationType(.choose)
        print("New Location Button Tapped...")
    }
    
    func passLocationType(_ type: LocationType) {
        self.dismiss(animated: true)
        delegate?.locationWasChosen(with: type)
    }    
}
