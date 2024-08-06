//
//  ContentView.swift
//  s24-apple-maps-project
//
//  Created by Hamzah Yousuf on 4/10/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var mapAPI = MapAPI()
    @StateObject private var searchHistory = SearchHistory()
    
    @State private var showSearch = false
    @State private var text = ""
    @State private var showRecents = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                // Could not figure out a more up to date implementation
                Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations) { location in
                    MapMarker(coordinate: location.coordinate, tint: .orange)
                }
                .ignoresSafeArea()
                
                
                
                VStack {
                    HStack {
                        Spacer() // Pushing to the right
                        VStack {
                            NavigationLink(destination: RecentsView(recentSearches: $searchHistory.searches), isActive: $showRecents) {
                                Button(action: {
                                    showRecents.toggle()
                                }) {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .imageScale(.large)
                                        .padding()
                                        .frame(width: 50, height: 50)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            Button(action: { zoomIn() }) {
                                Image(systemName: "plus.magnifyingglass")
                                    .padding()
                                    .frame(width: 40, height: 40) // Specifying the frame for uniformity
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            Button(action: { zoomOut() }) {
                                Image(systemName: "minus.magnifyingglass")
                                    .padding()
                                    .frame(width: 40, height: 40)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    Spacer() // Pushing it to the top
                }
                .padding() // To pad that marvelous VStack
                
                VStack {
                    Spacer()
                    Button(action: {
                        showSearch = true
                    }) {
                        Text("Enter an address")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                SearchView(mapAPI: mapAPI, searchHistory: searchHistory, isShowing: $showSearch)

                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .statusBar(hidden: true)
        }
    }
        func zoomIn() {
            mapAPI.region.span.latitudeDelta *= 0.7
            mapAPI.region.span.longitudeDelta *= 0.7
        }
        func zoomOut() {
            mapAPI.region.span.latitudeDelta /= 0.7
            mapAPI.region.span.longitudeDelta /= 0.7
        }
    }


#Preview {
    ContentView()
}
