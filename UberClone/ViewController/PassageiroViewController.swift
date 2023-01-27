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
    var calledUber = false
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func chamarUber(_ sender: Any) {
        let database = Database.database().reference()
        let request = database.child("requisicoes")
        let auth = Auth.auth()
        
        
        if let email = auth.currentUser?.email {
            if calledUber == true {
                self.changeCallButton()
            } else {
                self.changeCallButton()
                
                let userData = [
                    "email": email,
                    "nome": "Vitor Scheffer",
                    "latitude" : self.userLocation.latitude,
                    "longitude" : self.userLocation.longitude
                ] as [String : Any]
                request.childByAutoId().setValue( userData )
            }
        }
    }
    
    private func changeCallButton() {
        if !calledUber {
            self.botaoChamar.backgroundColor = UIColor(displayP3Red: 0.831, green: 0.237, blue: 0.146, alpha: 1)
            self.botaoChamar.setTitle("Cancelar Uber", for: .normal)
            self.calledUber = true
        } else {
            self.botaoChamar.setTitle("Chamar Uber", for: .normal)
            self.botaoChamar.backgroundColor = UIColor(displayP3Red: 0.067, green: 0.576, blue: 0.604, alpha: 1)
            self.calledUber = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = manager.location?.coordinate {
            self.userLocation = coordinate
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
            mapa.setRegion(region, animated: true)
            
            mapa.removeAnnotations( mapa.annotations )
            
            let userPoint = MKPointAnnotation()
            userPoint.coordinate = coordinate
            userPoint.title = "Seu local"
            mapa.addAnnotation( userPoint )
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
