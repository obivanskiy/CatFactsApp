//
//  ViewController.swift
//  catFactsApp
//
//  Created by Ivan Obodovskyi on 1/4/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import  Firebase


class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        signInAction()

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserSession()
        self.hideKeyboard()
        password.isSecureTextEntry = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        
    }
    func checkUserSession() {
        if Auth.auth().currentUser != nil {
        self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
    }  else {
        let alertController = UIAlertController(title: "You are not logged in", message: "Please, enter your log in data!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion:  nil)
                    }
    }
// Firebase sign in function
    func signInAction() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {(user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "enterTheMainView", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion:  nil)
            }
        }
    }
 
}
extension UIViewController{
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

