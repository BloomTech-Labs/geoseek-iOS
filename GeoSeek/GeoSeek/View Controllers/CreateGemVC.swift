//
//  SecondViewController.swift
//  GeoSeek
//
//  Created by Jerry haaser on 2/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class CreateGemVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var giveGemTitleLabel: UILabel!
    @IBOutlet weak var gemTitleTextField: UITextField!
    @IBOutlet weak var gemLocationLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var addDescriptionLabel: UILabel!
    @IBOutlet weak var gemDescriptionTextView: UITextView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyLevelTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    //Note: Do we want a "tab bar" here at all?
    @IBOutlet weak var customTabBarXib: CustomTabBarXib!
    
    var coordinator: CreateGemCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SecondVeiwController.viewDidLoad")
//        customTabBarXib.coordinator = coordinator
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard isViewLoaded else { return }
        super.viewDidAppear(animated)
        gemDescriptionTextView.backgroundColor = .lightGray
        
    }

    @IBAction func locationButtonTapped(_ sender: Any) {
//        print("do something", coordinator)
        coordinator?.presentGSMapViewControllerOnMainThread()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("cancelButtonTapped")
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        var gemTitle = gemTitleTextField.text
        var gemDesc = gemDescriptionTextView.text
        var difficulty = 1.0//Double(difficultyLevelTextField.text)
//        var gemCoords = coordinator?.addGemCoordinates
//        print(gemCoords as Any)
//        var gemLat = coordinator?.gemLat
//        print("Lat is \(gemLat)")
//        var gemLong = coordinator?.gemLong
//        print("Long is \(gemLong)")
    
//        
//        coordinator?.gemController.createGem(title: gemTitle, gemDesc: gemDesc, difficulty: difficulty, id: <#T##Int#>, latitude: gemLat, longitude: gemLong, createdByUser: <#T##Int#>)
//        coordinator?.toVCOne()
    }
    
}
