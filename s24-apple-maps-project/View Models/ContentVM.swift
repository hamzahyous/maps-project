//
//  ContentVM.swift
//  s24-apple-maps-project
//
//  Created by Hamzah Yousuf on 4/14/24.
//

import Foundation
import MapKit

class ContentVM: ObservableObject {
    @Published var mapAPI: MapAPI
    @Published var showSearch: Bool = false
    
    init(mapAPI: MapAPI) {
        self.mapAPI = mapAPI
    }
    
    
    // Whenever I would try to pass these functions through content view, I would have errors in getting the buttons to function so I defined them within the ContentView file.
    
    func zoomIn() {
        mapAPI.region.span.latitudeDelta *= 0.7
        mapAPI.region.span.longitudeDelta *= 0.7
    }
    
    func zoomOut() {
        mapAPI.region.span.latitudeDelta /= 0.7
        mapAPI.region.span.longitudeDelta /= 0.7
    }
}
