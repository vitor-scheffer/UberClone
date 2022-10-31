//
//  ViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 28/10/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let autenticacao = Auth.auth()
        
        autenticacao.addStateDidChangeListener { autenticacao, usuario in
            if let usuarioLogado = usuario {
                self.performSegue(withIdentifier: "segueLoginPrincipal", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

