//
//  SecondViewController.swift
//  GeoSeek
//
//  Created by Jerry haaser on 2/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var customTabBarXib: CustomTabBarXib!
    
    weak var coordinator: MainCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SecondVeiwController.viewDidLoad")
//        customTabBarXib.coordinator = coordinator
    }

}
