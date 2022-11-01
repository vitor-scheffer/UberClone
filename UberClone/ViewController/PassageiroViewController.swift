//
//  PassageiroViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 31/10/22.
//

import UIKit
import FirebaseAuth
import MapKit

class PassageiroViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordenadas = manager.location?.coordinate {
            let regiao = MKCoordinateRegion(center: coordenadas, latitudinalMeters: 300, longitudinalMeters: 300)
            mapa.setRegion(regiao, animated: true)
            
            mapa.removeAnnotations( mapa.annotations )
            
            let anotacaoUsuario = MKPointAnnotation()
            anotacaoUsuario.coordinate = coordenadas
            anotacaoUsuario.title = "Seu local"
            mapa.addAnnotation( anotacaoUsuario )
        }
    }
    
    @IBAction func handleSignOut(_ sender: Any) {
        let autenticacao = Auth.auth()
        do {
            try autenticacao.signOut()
            dismiss(animated: true)
        } catch {
            print("Não foi possível deslogar usuário!")
        }
    }
}
