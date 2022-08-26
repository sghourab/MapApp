//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Summer Crow on 2022-03-11.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject{
    
    //All loaded locations
    @Published var locations: [Location]
    
    //Current location on the map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    
    @Published var showLocationList: Bool = false
    
    // Show location detail via sheet
    
    @Published var sheetLocation: Location? = nil
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        
        self.mapLocation = locations.first!
        self.updateMapRegion(location: mapLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList(){
         
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
           mapLocation = location
           showLocationList = false
        }
    }
    
    func nextButtonPressed(){
       
        //Get the current index
        print(locations.count)
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("could not find, should never happen")
            return
        }
        //print(currentIndex)
        
        //check if current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        
        //Next index IS valid:
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
//        if currentIndex == locations.count - 1 {
//            showNextLocation(location: locations.first!)
//        } else {
//
//                showNextLocation(location: locations[currentIndex + 1])
//        }
    }
}
