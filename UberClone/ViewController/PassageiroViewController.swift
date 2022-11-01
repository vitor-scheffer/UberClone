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
    
    @IBOutlet weak var botaoChamar: UIButton!
    @IBOutlet weak var mapa: MKMapView!
    var uberChamado = false
    
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
            if uberChamado == true {
                self.alternaBotaoChamar()
            } else {
                self.alternaBotaoCancelar()
                
                let dadosUsuario = [
                    "email": emailUsuario,
                    "nome":"Vitor Passageiro",
                    "latitude" : self.localUsuario.latitude,
                    "longitude" : self.localUsuario.longitude
                ] as [String : Any]
                requisicao.childByAutoId().setValue( dadosUsuario )
            }
            
        }
        
    }
    
    func alternaBotaoChamar() {
        self.botaoChamar.setTitle("Chamar Uber", for: .normal)
        self.botaoChamar.backgroundColor = UIColor(displayP3Red: 0.067, green: 0.576, blue: 0.604, alpha: 1)
        self.uberChamado = false
    }
    
    func alternaBotaoCancelar() {
        self.botaoChamar.backgroundColor = UIColor(displayP3Red: 0.831, green: 0.237, blue: 0.146, alpha: 1)
        self.botaoChamar.setTitle("Cancelar Uber", for: .normal)
        self.uberChamado = true
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
