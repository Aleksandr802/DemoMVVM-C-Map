//
//  RecreationMapView.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/28/24.
//

import SwiftUI
import MapKit

struct RecreationMapView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var showPlaceLookup = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                    .ignoresSafeArea()
                
                VStack {
                    Button(action: {
                        showPlaceLookup.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Place")
                            .padding(.horizontal, 80)
                            .frame(height: 20)
                            .cornerRadius(8)
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("User Lat: \(String(format: "%.5f", locationManager.userLat))")
                            Text("User Long: \(String(format: "%.5f", locationManager.userLong))")
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            locationManager.updateMapToUsersLocation()
                        }) {
                            Image(systemName: "location.fill")
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .frame(width: 64, height: 64)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showPlaceLookup, content: {
            PlacesLookupView()
        })
    }
}

#Preview {
    RecreationMapView()
}
