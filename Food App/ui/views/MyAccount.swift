//
//  MyAccount.swift
//  Food App
//
//  Created by alihizardere on 21.10.2023.
//

import UIKit
import Firebase

class MyAccount: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logOutbtn(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toWelcome", sender: nil)
        }catch{
            print("Error")
        }
    }
}
