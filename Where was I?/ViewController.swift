//
//  ViewController.swift
//  Where was I?
//
//  Created by Andrii Kyrychenko on 14/06/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    @IBAction func saveButtonClick(_ sender: Any) {
        let coordinate = locationManager.location?.coordinate
        
        guard let lat = coordinate?.latitude else { return }
        guard let long = coordinate?.longitude else { return }
        
        DataStore().storeDatePoin(lanitude: String(lat), longitude: String(long))
        getAnotation()
        //setCoordinate()
    }
    
    func setCoordinate() {
        // Set initial location in Honolulu
        let locLat = CLLocationDegrees(21.282778)
        let locLong = CLLocationDegrees(-157.829444)
        let initialLocation = CLLocationCoordinate2D(latitude: locLat, longitude: locLong)
        let disLat = CLLocationDistance(300)
        let disLong = CLLocationDistance(300)
        let coor = MKCoordinateRegion(center: initialLocation, latitudinalMeters: disLat, longitudinalMeters: disLong)
        
        mapView.setRegion(coor, animated: true)
        
        
        

    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getAnotation()
    }
    
    func getAnotation() {
        guard let oldCoords = DataStore().getLastLocation() else { return }
        let anotation = MKPointAnnotation()
        anotation.coordinate.latitude = Double(oldCoords.latitude)!
        anotation.coordinate.longitude = Double(oldCoords.longitude)!
        
        anotation.title = "I was here!"
        anotation.subtitle = "Remember?"
        mapView.addAnnotation(anotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            print("location not enabled")
            return
        }
        mapView.showsUserLocation = true
    }
}

