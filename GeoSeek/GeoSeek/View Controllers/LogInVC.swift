//
//  LogInVC.swift
//  GeoSeek
//
//  Created by morse on 3/13/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

protocol LogInDelegate {
    func attemptLogIn(with username: String, password: String)
}

class LogInVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var delegate: LogInDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
}
