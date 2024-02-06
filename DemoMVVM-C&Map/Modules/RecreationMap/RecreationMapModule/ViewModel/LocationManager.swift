//
//  RecreationMapViewModel.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/28/24.
//

import Foundation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject {
    
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    
    @Published var searchText = ""
    
    var cancellable: AnyCancellable?
    
//    @Published var userLat: Double = 0.0
//    @Published var userLong: Double = 0.0
    
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900, longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.delegate = self
        
        //MARK: Requesting Location Acces
        manager.requestWhenInUseAuthorization()
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                
            })
    }
    
    func updateMapToUsersLocation() {
        let coordinate = manager.location!.coordinate
        region.center = coordinate
//        userLat = coordinate.latitude
//        userLong = coordinate.longitude
    }
}

extension LocationManager: MKMapViewDelegate {
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    //MARK: Location autorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            handleLocationError()
        case .authorizedAlways:
            manager.requestLocation()
            updateMapToUsersLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
            updateMapToUsersLocation()
        default:
            ()
        }
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        locations.last.map { location in
            DispatchQueue.main.async { [weak self] in
                self?.region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
//                self?.userLat = location.coordinate.latitude
//                self?.userLong = location.coordinate.longitude
            }
        }
    }
    
    func handleLocationError() {
        
    }
}
