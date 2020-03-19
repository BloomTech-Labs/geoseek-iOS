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
    var gem: Gem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setViews()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
    }
    
    private func setViews() {
        guard let gem = gem else { return }
        gemTitleLabel.text = gem.title
       // categoryLabel.text = gem.category
        gemDescriptionTextView.text = gem.description
        difficultyLabel.text = "\(gem.difficulty)"
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

extension GemDetailVC: MGLMapViewDelegate {
    // Added this but not sure it belongs here
    
//  func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
//    // Optionally handle taps on the callout.
//   // let gdvc = GemDetailVC()
//    self.present(self, animated: true, completion: nil)
//    //present(gdvc, animated: true, completion: nil)
//    print("Tapped the callout for: \(annotation)")
//
//    // Hide the callout.
//    mapView.deselectAnnotation(annotation, animated: true)
//    }
}
