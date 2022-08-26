//
//  LocationsView.swift
//  MapApp
//
//  Created by Summer Crow on 2022-03-11.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700

    
    
    var body: some View {
        ZStack {
            
                mapView
                .ignoresSafeArea()
            
            VStack (spacing: 0){
                header
                .padding()
                .frame(maxWidth: maxWidthForIpad)
                
                Spacer()
                
                
                locationsPreviewStack
               
            }
            
        }
        .sheet(item: $vm.sheetLocation,
               onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
        
    
    }
    
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    
    private var header: some View {
        
            VStack {
                Button {
                    vm.toggleLocationsList()
                } label: {
                    Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: vm.mapLocation)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                        }
                }

                if vm.showLocationList {
                LocationsListView()
                }
            }
                
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        }
    private var mapView: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            //MapMarker(coordinate: location.coordinates, tint: .blue)
            MapAnnotation(coordinate: location.coordinates) {
               LocationMapAnnotationView()
                    .scaleEffect(
                        vm.mapLocation == location ? 1 : 0.7)
                    .shadow(color: .gray, radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        
        })
    }
    
    private var locationsPreviewStack: some View {
        
        ZStack {
            ForEach(vm.locations) { location in
                
                if location == vm.mapLocation{
                LocationPreviewView(location: vm.mapLocation)
                    .shadow(color: .black.opacity(0.3), radius: 20)
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                    .frame(maxWidth: .infinity) 
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)))
                }
            }
        }
        
    }

}

