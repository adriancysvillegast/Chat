//
//  RegisterViewController.swift
//  Chat
//
//  Created by Adriancys Jesus Villegas Toro on 17/12/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
                if let e = error{
                    print("We have a error when create your account \(e)")
                }else{
                    self.performSegue(withIdentifier: K.Segue.registerToChat, sender: self)
                }
            }
        }
    }
}

