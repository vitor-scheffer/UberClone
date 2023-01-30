//
//  MotoristaTableViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 29/01/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class DriverTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var driverLocation = CLLocationCoordinate2D() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var requestsList: [DataSnapshot] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = locationManager.location?.coordinate {
            self.driverLocation = coordinates
        }
    }
    
    private func getData() {
        
        let database = Database.database().reference()
        let requests = database.child("requisicoes")
        
        requests.observe(.childAdded) { snapshot in
            self.requestsList.append(snapshot)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requestsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverViewCell", for: indexPath)
        let snapshot = self.requestsList[indexPath.row]
        
        if let data = snapshot.value as? [String: Any] {
            if let latPassenger = data["latitude"] as? Double {
                if let lonPassenger = data["longitude"] as? Double {
                    
                    let driverLocation = CLLocation(latitude: self.driverLocation.latitude, longitude: self.driverLocation.longitude)
                    
                    let passengerLocation = CLLocation(latitude: latPassenger, longitude: lonPassenger)
                    
                    let metersDistence = driverLocation.distance(from: passengerLocation)
                    let KMdistance = metersDistence / 1000
                    let formattedDistance = round(KMdistance)
                    
                    let minPrice = 4.0
                    let priceByKM = 1.70
                    let totalPrice = minPrice + (formattedDistance * priceByKM)
                    let formattedPrice = round(totalPrice)
                    
                    cell.textLabel?.text = data["nome"] as? String
                    cell.detailTextLabel?.text = "\(formattedDistance) KM de distância | R$ \(formattedPrice)"
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snapshot = self.requestsList[indexPath.row]
        
        performSegue(withIdentifier: "SegueAceitarCorrida", sender: snapshot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SegueAceitarCorrida" {
            let confirmVC = segue.destination as? ConfirmRequestViewController
            
            if let snapshot = sender as? DataSnapshot {
                guard let data = snapshot.value as? [String: Any] else {return}
                guard let latPassenger = data["latitude"] as? Double else {return}
                guard let lonPassenger = data["longitude"] as? Double else {return}
                let name = data["nome"] as? String
                
                let passengerLocation = CLLocationCoordinate2D(latitude: latPassenger, longitude: lonPassenger)
                
                confirmVC?.passengerName = name
                confirmVC?.driverLocation = self.driverLocation
                confirmVC?.passengerLocation = passengerLocation
                
            }
        }
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
