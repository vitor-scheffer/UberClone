//
//  PassageiroViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 31/10/22.
//

import UIKit
import FirebaseAuth
import MapKit

class PassageiroViewController: UIViewController {
    
    @IBOutlet weak var mapa: MKMapView!
    
    @IBAction func handleSignOut(_ sender: Any) {
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            dismiss(animated: true)
        } catch {
            print("Não foi possível deslogar usuário!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
