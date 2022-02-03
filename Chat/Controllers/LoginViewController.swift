//
//  LoginViewController.swift
//  Chat
//
//  Created by Adriancys Jesus Villegas Toro on 20/12/21.
//

import UIKit
import Firebase

class LoginViewController : UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text,
        let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
                if let e = error{
                   print(e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: K.Segue.loginToChat, sender: self)
                }
            }
        }
        
    }
    
}
