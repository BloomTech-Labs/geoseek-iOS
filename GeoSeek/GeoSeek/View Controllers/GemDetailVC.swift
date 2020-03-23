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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        guard let gem = gem else { return }
        delegate?.markGemCompleted(gem, comments: "")
        congratulationsLabel.isHidden = false
        youFoundGemLabel.isHidden = false
        congratulationsLabel.textColor =  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        youFoundGemLabel.textColor =  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        youFoundGemLabel.text = "You found the \(gem.title ?? "") gem."
    }
    
    @IBAction func addCommentButtonTapped(_ sender: UIButton) {
        
    }
    
    private func setViews() {
        guard let gem = gem else { return }
        gemTitleLabel.text = gem.title
        gemDescriptionTextView.text = gem.gemDesc
        difficultyLabel.text = "\(gem.difficulty)"
//        congratulationsLabel.isHidden = true
//        youFoundGemLabel.isHidden = true

    }
    
}
