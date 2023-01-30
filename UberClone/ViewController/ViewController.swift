//
//  ViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 28/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let autenticacao = Auth.auth()
        
        autenticacao.addStateDidChangeListener { autenticacao, usuario in
            if let user = usuario {
                let database = Database.database().reference()
                let users = database.child("usuarios").child(user.uid)
                
                users.observeSingleEvent(of: .value) { snapshot in
                    
                    guard let userData = snapshot.value as? NSDictionary else { return }
                    let userType = userData["tipo"] as! String
                    
                    if userType == "passageiro" {
                        self.performSegue(withIdentifier: "segueLoginPrincipal", sender: nil)

                    } else {
                        self.performSegue(withIdentifier: "segueLoginPrincipalMotorista", sender: nil)
                    }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

