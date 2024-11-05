//
//  LocationsViewModel.swift
//  SwiftUIMap
//
//  Created by Taras Prystupa on 05.11.2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    //All loaded locations
    @Published var locations: [Location]
    
    //Curent location
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(mapLocation: mapLocation)
        }
    }
    
    //Current region on map
    @Published var mapRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //map feachure
    @Published var mapSelected: MapFeature?
    
    //show list of location
    @Published var showLocationList: Bool = false
    
    //show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init () {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(mapLocation: locations.first)
    }
    
    private func updateMapRegion(mapLocation : Location?) {
        guard let mapLocation else { return }
        
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(
                center: mapLocation.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            self.showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            self.mapLocation = location
            self.showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        //get current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        //check next index is valid
        let nextIndex = currentIndex.advanced(by: 1)
        guard locations.indices.contains(nextIndex) else {
            //next index is not valid
            //start from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        //next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
