//
//  MenuViewController.swift
//  GeoSeek
//
//  Created by Brandi Bailey on 3/12/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreData

protocol MenuVCDelegate {
    func goToAddGemView()
    func goToSignInView()
}

class MenuVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var menuView: UIView?
    @IBOutlet weak var mapviewButton: UIButton!
    @IBOutlet weak var listViewButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var addGemButton: UIButton!
    @IBOutlet weak var exitMenuButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var logInOutButton: UIButton!
    
    var delegate: MenuVCDelegate?
    let user = User.retrieveUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayUserInfo()
        configureExitButton()
    }
    
    func displayUserInfo() {
        if let user = user,
            let userName = user.username {
            userNameLabel.text = "Hello, \(userName)"
            logInOutButton.setTitle("Logout", for: .normal)
        } else {
            userNameLabel.text = "Sign in to create gems and mark them complete."
            logInOutButton.setTitle("Login", for: .normal)
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
        if let _ = user {
            User.removeUser()
            displayUserInfo()
            dismiss(animated: true)
        } else {
            print("We're hitting this")
            delegate?.goToSignInView()
            dismiss(animated: true)
        }
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func mapViewButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func listViewButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addGemButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        delegate?.goToAddGemView()
    }
    
}
