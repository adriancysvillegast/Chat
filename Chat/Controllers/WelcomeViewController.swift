//
//  ViewController.swift
//  Chat
//
//  Created by Adriancys Jesus Villegas Toro on 17/12/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
//    metodo para eliminar la barra de navigacion
// viewWillAppear SUCEDE CUANDO LA APP SE INICIA PERO AUN EL USUARIO NO VE NADA 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
//    metodo para mostrar la barra de navegacion en la siguente pagina
    override func viewWillDisappear(_ animated: Bool) {
//        call to the super is a good practi
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var index = 0.0
        let title = K.appName
        
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) { Timer in
                self.titleLabel.text?.append(letter)
                
            }
            index += 1
        }
    }


}

