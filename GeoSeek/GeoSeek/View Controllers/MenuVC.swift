//
//  MenuViewController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/12/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreData

class MenuVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var menuView: UIView?
    @IBOutlet weak var mapviewButton: UIButton!
    @IBOutlet weak var listViewButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var addGemButton: UIButton!
    @IBOutlet weak var exitMenuButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var delegate: MenuDelegate?
    var coordinator: MenuCoordinator?
    let user = User.retrieveUser()
//    var navigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayUserInfo()
        configureExitButton()
    }
    
    func displayUserInfo() {
        if let user = user,
            let userName = user.username {
            userNameLabel.text = "Hello, \(userName)"
        } else {
            userNameLabel.text = "Hello, please sign in."
        }
        
        if let user = user,
            let userEmail = user.email {
            print("User Email:", userEmail)
            userEmailLabel.text = "\(userEmail)"
        } else {
            userEmailLabel.text = ""
        }
    }
    
        func configureExitButton() {
            exitMenuButton.layer.cornerRadius = 24
        }
    
    @IBAction func logoutTapped(_ sender: Any) {
        User.removeUser()
        displayUserInfo()
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
