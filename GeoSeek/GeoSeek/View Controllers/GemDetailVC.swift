//
//  GemDetailViewController.swift
//  GeoSeek
//
//  Created by Jerry haaser on 3/18/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import Mapbox

class GemDetailVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var gemIconImageView: UIImageView!
    @IBOutlet weak var gemTitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var gemDescriptionTextView: UITextView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    var coordinator: BaseCoordinator?
    var delegate: GemDetailVCCoordinatorDelegate?
    var gemController: GemController?
    var locationManager: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCommentButtonTapped(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
