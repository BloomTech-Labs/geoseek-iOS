//
//  MenuViewController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/12/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, Storyboarded {

    @IBOutlet weak var menuView: UIView?
    @IBOutlet weak var mapviewButton: UIButton!
    @IBOutlet weak var listViewButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var addGemButton: UIButton!
    @IBOutlet weak var exitMenuButton: UIButton!
    
    var delegate: MenuDelegate?
    var coordinator: BaseCoordinator?
    var controller: NetworkController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        configureExitButton()
    }
    
//    func configureExitButton() {
//        exitMenuButton.layer.cornerRadius = 50
//    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        controller?.removeUser()
    }
    
}
