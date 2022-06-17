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
    
    @IBOutlet weak var longTextBox: UITextField!
    @IBOutlet weak var latTextBox: UITextField!

    @IBAction func saveButtonClick(_ sender: Any) {
        let coordinate = locationManager.location?.coordinate
        
        guard let lat = coordinate?.latitude else { return }
        guard let long = coordinate?.longitude else { return }
        
        DataStore().storeDatePoin(lanitude: String(lat), longitude: String(long))
        getAnotation()
        
    }
    
    @IBAction func markButtonClick(_ sender: Any) {
        
        guard let latitudeWant = Float(longTextBox.text ?? "") else { return }
        guard let longitudeWant = Float(latTextBox.text ?? "") else { return }
        let locLat = CLLocationDegrees(latitudeWant)
        let locLong = CLLocationDegrees(longitudeWant)
        
        let anotation = MKPointAnnotation()
        anotation.coordinate.latitude = locLat
        anotation.coordinate.longitude = locLong
        
        anotation.title = "I want to here!"
        mapView.addAnnotation(anotation)
    }
    
    @IBAction func goButtonClick(_ sender: Any) {
        guard let lat = Float(longTextBox.text ?? "") else { return }
        guard let long = Float(latTextBox.text ?? "") else { return }
        if (lat < -90.0 || lat > 90.0) || (long < -180.0 || long > 180.0) {
            return
        } else {
            setCoordinate(latDegrees: lat, longDegrees: long)
        }
        
    }
    
    func setCoordinate(latDegrees: Float, longDegrees: Float) {
        // Set initial location in Honolulu
        let locLat = CLLocationDegrees(latDegrees)
        let locLong = CLLocationDegrees(longDegrees)
        let initialLocation = CLLocationCoordinate2D(latitude: locLat, longitude: locLong)
        let disLat = CLLocationDistance(400)
        let disLong = CLLocationDistance(400)
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
    
    
    @IBAction func longitudeTextBox(_ sender: Any) {
    }
    @IBAction func latitudeTextBox(_ sender: Any) {
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

