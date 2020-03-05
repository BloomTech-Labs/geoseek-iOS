//
//  CreteGemCoordinator.swift
//  GeoSeek
//
//  Created by morse on 3/4/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

protocol CreateGemCoordinatorDelegate {
    func presentChooseLocationVC()
    func presentGemsMap()
}

class CreateGemCoordinator: BaseCoordinator {
//    let window: UIWindow
    var navigationController: UINavigationController?
    var delegate: CreateGemCoordinatorDelegate?
    
    //    var gemLat: Double?
    //    var gemLong: Double?
    
    // delegate
    
//    init(window: UIWindow) {
//        self.window = window
//    }
    
    override func start() {
        
//        navigationController = UINavigationController()
//        window.rootViewController = navigationController
        navigationController?.isNavigationBarHidden = true
        
        let vc = CreateGemVC.instantiate()
        vc.coordinator = self
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
//
//        if let vc = navigationController?.viewControllers.first {
//            print(vc.description)
//        } else {
//            let vc = CreateGemVC.instantiate()
//            vc.coordinator = self
//            navigationController?.pushViewController(vc, animated: true)
//        }
        
        //        window.rootViewController =
    }
    
    func presentGSMapViewControllerOnMainThread() {
//        print("This should present", delegate)
//        DispatchQueue.main.async {
//            let mapVC = ChooseLocationVC()
//            mapVC.coordinator = self
//            mapVC.modalPresentationStyle = .overFullScreen
//            mapVC.modalTransitionStyle = .coverVertical
//            self.navigationController?.present(mapVC, animated: true)
            //            self.navControllers[1].present(mapVC, animated: true)
        }
        //        delegate?.presentChooseLocationVC()
        //        let chooseLocationCoordinator = ChooseLocationCoordinator(window: window)
        //        chooseLocationCoordinator.start()
//    }
    
    func toGemsMapViewController() {
        
        print("Tell app coordinator to present Gems Map")
        delegate?.presentGemsMap()
    }
}

extension CreateGemCoordinator: CreateGemDelegate {
    func getLocation() {
        let mapVC = ChooseLocationVC()
        mapVC.coordinator = self
        mapVC.modalPresentationStyle = .overFullScreen
        mapVC.modalTransitionStyle = .coverVertical
        self.navigationController?.present(mapVC, animated: true)
    }
}
