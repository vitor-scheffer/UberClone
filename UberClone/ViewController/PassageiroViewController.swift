//
//  PassageiroViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 31/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class PassageiroViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var localUsuario = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
    }
    
    
    @IBAction func chamarUber(_ sender: Any) {
        let database = Database.database().reference()
        let requisicao = database.child("requisicoes")
        let autenticacao = Auth.auth()
        
        if let emailUsuario = autenticacao.currentUser?.email {
            let dadosUsuario = [
                "email": emailUsuario,
                "nome":"Vitor Passageiro",
                "latitude" : self.localUsuario.latitude,
                "longitude" : self.localUsuario.longitude
            ] as [String : Any]
            requisicao.childByAutoId().setValue( dadosUsuario )
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordenadas = manager.location?.coordinate {
            self.localUsuario = coordenadas
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
