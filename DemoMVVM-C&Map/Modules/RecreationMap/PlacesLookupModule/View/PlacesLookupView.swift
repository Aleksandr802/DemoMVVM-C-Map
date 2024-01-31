//
//  PlacesLookupView.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/29/24.
//

import SwiftUI

struct PlacesLookupView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var placeVM = PlaceViewModel()
    
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List(placeVM.places) { place in
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.headline)
                    Text(place.address)
                        .font(.caption)
                }
            }
            .listStyle(.plain)
            .searchable(text: $locationManager.searchText)
            .onChange(of: locationManager.searchText, perform: { text in
                if !text.isEmpty {
                    placeVM.search(text: text, region: locationManager.region)
                } else {
                    placeVM.places = []
                }
            })
            .toolbar(content: {
                Button("Dismiss") {
                    dismiss()
                }
            })
        }
    }
}

#Preview {
    PlacesLookupView()
}
