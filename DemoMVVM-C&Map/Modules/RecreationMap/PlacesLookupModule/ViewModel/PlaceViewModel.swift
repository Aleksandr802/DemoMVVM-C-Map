//
//  PlaceViewModel.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/29/24.
//

import Foundation
import MapKit

@MainActor
class PlaceViewModel: ObservableObject {
    @Published var places: [Place] = []
    
    func search(text: String, region: MKCoordinateRegion) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response else {
                print("😡 \(error?.localizedDescription ?? "Uncknown Error")")
                return
            }
            
            self.places = response.mapItems.map(Place.init)
        }
    }
}
