//
//  SecondViewController.swift
//  GeoSeek
//
//  Created by Jerry haaser on 2/28/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import CoreLocation

protocol CreateGemDelegate {
    func getGemLocation()
    func createGem(_ gem: GemRepresentation)
}

class CreateGemVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var addGemView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var giveGemTitleLabel: UILabel!
    @IBOutlet weak var gemTitleTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var addDescriptionLabel: UILabel!
    @IBOutlet weak var gemDescriptionTextView: UITextView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyLevelTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    //Note: Do we want a "tab bar" here at all?
    @IBOutlet weak var customTabBarXib: CustomTabBarXib!
    
    var coordinator: BaseCoordinator?
    var delegate: CreateGemDelegate?
    var userLocation: CLLocationCoordinate2D?
    var gemLocation: CLLocationCoordinate2D? {
        didSet {
            print("CreateGemVC.gemLocation was set")
            if let gemLocation = gemLocation {
                print(gemLocation)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SecondVeiwController.viewDidLoad")
        
        styleAddGemView()
        gemTitleTextField.delegate = self
        gemDescriptionTextView.delegate = self
//        print(gemLocation)
    }
    

    func styleAddGemView() {
      addGemView.layer.cornerRadius = 20.0
      addGemView.clipsToBounds = true
      gemTitleTextField.layer.cornerRadius = 20.0
       
      gemDescriptionTextView.layer.cornerRadius = 10.0
      gemDescriptionTextView.clipsToBounds = true
       
      saveButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
//        print("do something", coordinator)
        delegate?.getGemLocation()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("cancelButtonTapped")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print(gemDescriptionTextView.text ?? "No gemDesc text", gemLocation?.latitude ?? "No location")
        guard let title = gemTitleTextField.text,
            !title.isEmpty,
            let desc = gemDescriptionTextView.text,
            !desc.isEmpty,
            let location = gemLocation else { return }
        
        let gem = GemRepresentation(difficulty: 5, description: desc, id: nil, latitude: location.latitude, longitude: location.longitude, title: title)
        
        delegate?.createGem(gem)
        navigationController?.popViewController(animated: true)
    }
}

extension CreateGemVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        gemTitleTextField.resignFirstResponder()
        gemDescriptionTextView.resignFirstResponder()
        
        return true
    }
}

extension CreateGemVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            gemDescriptionTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

