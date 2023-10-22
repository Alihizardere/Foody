//
//  WelcomePage.swift
//  Food App
//
//  Created by alihizardere on 20.10.2023.
//

import UIKit

class WelcomePage: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func btnSignIn(_ sender: Any) {
        performSegue(withIdentifier: "toLoginPage", sender: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterPage", sender: nil)
    }
    
}
