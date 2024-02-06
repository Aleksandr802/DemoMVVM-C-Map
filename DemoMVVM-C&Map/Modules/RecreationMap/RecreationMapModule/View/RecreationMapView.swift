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
    @State var returnedPlace = Place(mapItem: MKMapItem())
    @State var position: MapCameraPosition = .automatic
    
    var body: some View {
        NavigationStack {
            ZStack {
//                Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
//                    .ignoresSafeArea()
                
                Map(position: $position) {
                    Marker(returnedPlace.name, coordinate: CLLocationCoordinate2D(latitude: returnedPlace.latitude, longitude: returnedPlace.longitude))
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .safeAreaInset(edge: .top) {
                    Button(action: {
                        showPlaceLookup.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Place")
                            .padding(.horizontal, 80)
                            .frame(height: 30)
                            .cornerRadius(8)
                    })
                    .buttonStyle(.borderedProminent)
                }
                .safeAreaInset(edge: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Returned Place: \nName: \(returnedPlace.name) \nAddress: \(returnedPlace.address) \nCoords: \(returnedPlace.latitude), \(returnedPlace.longitude)")
                            .onTapGesture {
                                position = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: returnedPlace.latitude, longitude: returnedPlace.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                            }
                    }
                    .padding()
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }
                
//                VStack {
//                    Spacer()
//                    
//                    HStack {
//                        VStack(alignment: .leading) {
////                            Text("Returned Place: \nName: \(returnedPlace.name) \nAddress: \(returnedPlace.address) \nCoords: \(returnedPlace.latitude), \(returnedPlace.longitude)")
//                            Text("User Lat: \(String(format: "%.5f", locationManager.userLat))")
//                            Text("User Long: \(String(format: "%.5f", locationManager.userLong))")
//                        }
//                        .padding()
//                        
//                        Spacer()
//                        
//                        Button(action: {
//                            locationManager.updateMapToUsersLocation()
//                        }) {
//                            Image(systemName: "location.fill")
//                                .foregroundColor(.blue)
//                                .padding()
//                        }
//                        .frame(width: 64, height: 64)
//                        .background(Color.white)
//                        .clipShape(Circle())
//                        .padding()
//                    }
//                }
            }
        }
        .fullScreenCover(isPresented: $showPlaceLookup, content: {
            PlacesLookupView(returnedPlace: $returnedPlace, position: $position)
        })
    }
}

#Preview {
    RecreationMapView()
}
