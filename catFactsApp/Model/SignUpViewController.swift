//
//  SignUpViewController.swift
//  catFactsApp
//
//  Created by Ivan Obodovskyi on 1/5/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        guard let password = passwordTextField.text, password.count > 5 else {
            self.showAlert(withMessage: "Password needs to be more than 5 digits")
            return
        }
            let passwordConfirmation = repeatPasswordTextField.text
            if password != passwordConfirmation {
            self.showAlert(withMessage: "Passwords doesn't match, please, try again")
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: password) { (user, error) in
                if let error = error {
                    self.showAlert(withMessage: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "loginScreen", sender: self)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        passwordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true

    }
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok!", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
  

}


