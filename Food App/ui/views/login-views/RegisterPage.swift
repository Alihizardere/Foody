//
//  RegisterPage.swift
//  Food App
//
//  Created by alihizardere on 20.10.2023.
//

import UIKit
import Firebase

class RegisterPage: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func signUpClicked(_ sender: Any) {
        if emailLabel.text != "" && passwordLabel.text != ""{
            Auth.auth().createUser(withEmail: emailLabel.text!, password: passwordLabel.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    let alert = UIAlertController(title: "Kullanıcı Oluşturuldu", message: "Lütfen giriş yapınız.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Tamam", style: .cancel){action in
                        self.performSegue(withIdentifier: "signUpToSignIn", sender: nil)
                    }
                    alert.addAction(okButton)
                    self.present(alert, animated: true)
                }
            }
        }else{
          makeAlert(titleInput: "Error", messageInput: "Kullanıcı Adı/Şifre Giriniz.")
        }
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        performSegue(withIdentifier: "signUpToSignIn", sender: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
