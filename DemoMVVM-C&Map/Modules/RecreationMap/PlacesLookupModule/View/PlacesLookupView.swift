//
//  PlacesLookupView.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/29/24.
//

import SwiftUI
import MapKit

struct PlacesLookupView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var placeVM = PlaceViewModel()
    
    @Environment (\.dismiss) private var dismiss
    
    @Binding var returnedPlace: Place
    @Binding var position: MapCameraPosition
    
    var body: some View {
        NavigationStack {
            List(placeVM.places) { place in
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.headline)
                    Text(place.address)
                        .font(.caption)
                }
                .onTapGesture {
                    returnedPlace = place
                    position = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                    dismiss()
                }
            }
            .listStyle(.plain)
            .searchable(text: $locationManager.searchText)
            .onChange(of: locationManager.searchText, { oldValue, newValue in
                if !newValue.isEmpty {
                    placeVM.search(text: newValue, region: locationManager.region)
                } else {
                    placeVM.places = []
                }
            })
//            .onChange(of: locationManager.searchText, perform: { text in
//                if !text.isEmpty {
//                    placeVM.search(text: text, region: locationManager.region)
//                } else {
//                    placeVM.places = []
//                }
//            })
            .toolbar(content: {
                Button("Dismiss") {
                    dismiss()
                }
            })
        }
    }
}

#Preview {
    PlacesLookupView(returnedPlace: .constant(Place(mapItem: MKMapItem())), position: .constant(MapCameraPosition.automatic))
}
