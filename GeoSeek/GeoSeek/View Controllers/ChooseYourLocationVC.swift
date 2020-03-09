//
//  ChooseYourLocationVC.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/9/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class ChooseYourLocationVC: UIViewController, Storyboarded {
    
    var chooseLocationVC = ChooseLocationVC()
    var coordinator: BaseCoordinator?
    var delegate: CreateGemDelegate?
    var userLocation: CLLocationCoordinate2D?
    var gemLocation: CLLocationCoordinate2D? {
        didSet {
            print("CreateGemVC.gemLocation was set")
            if let gemLocation = gemLocation {
//                gemLocationLabel.text = "Latitude: \(gemLocation.latitude.rounded()), Longitude: \(gemLocation.longitude.rounded())"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func currentLocationTapped(_ sender: Any) {
    }
    
    @IBAction func newLocationTapped(_ sender: Any) {
        self.dismiss(animated: true)
        delegate?.getGemLocation()
         print("New Location Button Tapped...")
    }
}
