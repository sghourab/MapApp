//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Summer Crow on 2022-03-14.
//

import SwiftUI

struct LocationPreviewView: View {
    
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    
    let location: Location
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16.0) {
               imageSection
            titleSection
            }
            //.padding()
            VStack(alignment: .trailing, spacing: 8.0) {
                learnMoreButton
                   
                nextButton
            }.frame(maxWidth: .infinity, alignment: .trailing)
                //.padding()
            
        }.padding(20)
        .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.thinMaterial)
                    .offset(y: 65)
            )
        .cornerRadius(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        //.offset(y: -40)
        
        
       
        
      
        
           

            
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationsViewModel())
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(10)
                
            }
        }.padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 5) {
         
        Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        
    }
    
    private var learnMoreButton: some View {
       
            Button {
                vm.sheetLocation = location
            } label: {
                Text("Learn more")
                    .font(.headline)
                    .frame(width: 125, height: 35)
            }
            .buttonStyle(.borderedProminent)
           // .frame(maxWidth: .infinity, alignment: .trailing)

        }
    
    private var nextButton: some View {
        
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
       // .frame(maxWidth: .infinity, alignment: .trailing)

    }
}
