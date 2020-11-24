//
//  MapVC.swift
//  Weather2
//
//  Created by user on 24/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let location = CLLocationManager()
    
    
    var lat: Double = 0.0
    var lon: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        location.delegate = self
        mapView.delegate = self
        
        location.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        mapView.userLocation.title = "Im here"
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.coordinate.latitude != mapView.userLocation.coordinate.latitude && annotation.coordinate.longitude != mapView.userLocation.coordinate.longitude {
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            
            marker.canShowCallout = true
            let infoButton = UIButton(type: .detailDisclosure)
            infoButton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
            marker.rightCalloutAccessoryView = infoButton
            marker.calloutOffset = CGPoint(x: -5, y: 5)
            return marker
        }
        return nil
    }
    
    @objc func infoAction() {
        print("Info")
    }

    func mapToCoordinate(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: lat, longitudinalMeters: lon)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            mapToCoordinate(coordinate: location)
        }
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
