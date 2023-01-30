//
//  MotoristaTableViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 29/01/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MotoristaTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction private func didPressSignOut(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            
            dismiss(animated: true)
        } catch {
            print("Não foi possível deslogar usuário!")
        }
    }
}
