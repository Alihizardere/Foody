//
//  LoginPage.swift
//  Food App
//
//  Created by alihizardere on 20.10.2023.
//

import UIKit
import Firebase

class LoginPage: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailLabel.text != "" && passwordLabel.text != ""{
            Auth.auth().signIn(withEmail: emailLabel.text!, password: passwordLabel.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                }else{
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
            }
        }else{
           makeAlert(titleInput: "Hata", messageInput: "Kullanıcı Adı/Şifre Giriniz.")
        }
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        performSegue(withIdentifier: "signInToSignUp", sender: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}
