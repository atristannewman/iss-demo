//
//  ViewController.swift
//  ISS
//
//  Created by Tristan on 29/08/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var mapView: MKMapView! = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ISS Location"
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createData()
    }
    
    private func setUpView() {
        self.view.addSubview(mapView)
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func createData() {
        let service = NetworkService()
        
        service.getlocation { location, error in
            DispatchQueue.main.async {
                guard let position = location?["iss_position"] as? [String:Any] else { return }
                
                if let latitude =  position["latitude"] as? String, let longitude = position["longitude"] as? String {
                    self.plotISSOnMap(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
                }
            }
            
        }
    }
    
    private func plotISSOnMap(latitude: Double, longitude: Double) {
        let initialLocation = CLLocation(latitude:latitude, longitude: longitude)
        self.mapView.centerToLocation(initialLocation)
        
        let annotation = MKPointAnnotation()
        annotation.title = "ISS"
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.mapView.addAnnotation(annotation)
    }
  
}


private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 200000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
