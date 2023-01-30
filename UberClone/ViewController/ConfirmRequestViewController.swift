//
//  ConfirmarRequisicaoViewController.swift
//  UberClone
//
//  Created by José Vitor Scheffer Boff dos Santos on 30/01/23.
//

import UIKit
import MapKit

class ConfirmRequestViewController: UIViewController {
    
    var passengerName: String?
    var passengerEmail: String?
    var passengerLocation = CLLocationCoordinate2D()
    var driverLocation = CLLocationCoordinate2D()

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let region = MKCoordinateRegion(center: self.passengerLocation, latitudinalMeters: 300, longitudinalMeters: 300)
        map.setRegion(region, animated: true)

        let passengerPoint = MKPointAnnotation()
        passengerPoint.coordinate = passengerLocation
        passengerPoint.title = passengerName
        map.addAnnotation(passengerPoint)
    }

    @IBAction func didPressAcceptRacing(_ sender: Any) {
        
    }
}
