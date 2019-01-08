//
//  ViewController.swift
//  catFactsApp
//
//  Created by Ivan Obodovskyi on 1/4/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import  FirebaseAuth
import Alamofire

class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func logInButtonPressed(_ sender: AnyObject) {
        signInAction()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.hideKeyboard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)

        
    }
    func checkUserSession() {
        if Auth.auth().currentUser != nil {
        self.performSegue(withIdentifier: "logIn", sender: nil)
    }  else {
        let alertController = UIAlertController(title: "You are not logged in", message: "Please, enter log in data", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion:  nil)
                    }
    }
// Firebase sign in function
    func signInAction() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {(user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "logIn", sender: self)
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

