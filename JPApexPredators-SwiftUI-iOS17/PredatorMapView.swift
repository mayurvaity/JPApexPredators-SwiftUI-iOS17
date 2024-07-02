//
//  PredatorMapView.swift
//  JPApexPredators-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 02/07/24.
//

import SwiftUI
import MapKit

struct PredatorMapView: View {
    //to keep list of all predators
    let predators = Predators()
    
    //var to store location of dino
    @State var position: MapCameraPosition
    
    //var to toggle for satellite view
    @State var satellite = false
    
    var body: some View {
        //Map will cover the entire screen so no parent view for Map here
        Map(position: $position) {
            //to add all the predators at their corresponding locations 
            ForEach(predators.apexPredators) {
                predator in
                Annotation(predator.name,
                           coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        //mapStyle -  to change the style of map, in this case 3d view
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            //adding button to toggle between satellite view and standard view
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle) //to make image larger
                    .imageScale(.large) //to make image larger
                    .padding(3)
                    .background(.ultraThinMaterial)  //to make bg semitransparent
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic) //fixes issue with toolbar showing blur abv
    }
}

#Preview {
    PredatorMapView(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location,
                                                distance: 1000,
                                                heading: 250,
                                                pitch: 80))
    )
    .preferredColorScheme(.dark)
}
