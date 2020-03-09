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
    
    var delegate: ChooseLocationDelegate?

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
