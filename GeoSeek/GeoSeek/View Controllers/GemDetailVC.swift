//
//  GemDetailViewController.swift
//  GeoSeek
//
//  Created by Jerry haaser on 3/18/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

protocol GemDetailDelegate {
    func markGemCompleted(_ gem: Gem, comments: String)
}

class GemDetailVC: UIViewController, Storyboarded {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gemDetailView: UIView!
    
    @IBOutlet weak var checkButton: UIButton!

    @IBOutlet weak var gemTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var congratulationsLabel: UILabel!
    @IBOutlet weak var youFoundGemLabel: UILabel!
    

    @IBOutlet weak var gemDescriptionTextView: UITextView!
    @IBOutlet weak var gemIconImageView: UIImageView!
    @IBOutlet weak var commentsTableView: UITableView!
    
    
    var coordinator: BaseCoordinator?
    var delegate: GemDetailDelegate?
    var gemController: GemController?
    var locationManager: CLLocationManager?
    var gem: Gem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        guard let gem = gem else { return }
        delegate?.markGemCompleted(gem, comments: "")
    }
    
    @IBAction func addCommentButtonTapped(_ sender: UIButton) {
        
    }
    
    private func setViews() {
        
        containerView.layer.cornerRadius = 30
        containerView.clipsToBounds = true
        containerView.layer.cornerCurve = .continuous
        
        gemDetailView.layer.cornerRadius = 30
        gemDetailView.clipsToBounds = true
        
        guard let gem = gem else { return }
        gemTitleLabel.text = gem.title
        gemDescriptionTextView.text = gem.gemDesc
        difficultyLabel.text = "\(gem.difficulty)"
        
        guard let _ = User.retrieveUser() else {
            print("no user")
            checkButton.isHidden = true
            return
        }
    }
    
    func showLabel() {
        congratulationsLabel.isHidden = false
        youFoundGemLabel.isHidden = false
        congratulationsLabel.textColor =  Colors.gsPink
        youFoundGemLabel.textColor =  Colors.gsPink
        youFoundGemLabel.text = "You found the \(gem?.title ?? "") gem."
    }
    
}
