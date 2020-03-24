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

class CreateGemVC: ShiftableViewController, KeyboardShiftable, Storyboarded, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var addGemView: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var gemTitleTextField: UITextField!
    @IBOutlet weak var addDescriptionLabel: UILabel!
    @IBOutlet weak var gemDescriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var coordinator: BaseCoordinator?
    var delegate: CreateGemDelegate?
    var userLocation: CLLocationCoordinate2D?
    var gemLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gemTitleTextField.delegate = self
        gemDescriptionTextView.delegate = self
        styleAddGemView()
        setBottomView()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {

        guard let title = gemTitleTextField.text,
            !title.isEmpty,
            let desc = gemDescriptionTextView.text,
            !desc.isEmpty,
            let location = gemLocation else { return }
        
        guard let user = User.retrieveUser() else { return }
        
        let gem = GemRepresentation(difficulty: 5.0, description: desc, id: nil, latitude: location.latitude, longitude: location.longitude, title: title, createdByUser: Int(user.id))
        
        delegate?.createGem(gem)
    }
    
    func setBottomView() {
        bottomView = saveButton
    }
    
    func styleAddGemView() {
        
        viewContainer.layer.cornerRadius = 30
        viewContainer.clipsToBounds = true
        viewContainer.layer.cornerCurve = .continuous

        addGemView.layer.cornerRadius = 30.0
        addGemView.clipsToBounds = true
        
        gemTitleTextField.layer.cornerRadius = 6.0
        
        gemDescriptionTextView.layer.cornerRadius = 10.0
        gemDescriptionTextView.clipsToBounds = true
        
        saveButton.layer.cornerRadius = 10.0
    }
}
