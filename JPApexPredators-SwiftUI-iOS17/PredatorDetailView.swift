//
//  PredatorDetailView.swift
//  JPApexPredators-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 01/07/24.
//

import SwiftUI

struct PredatorDetailView: View {
    
    //var to store selected predator data
    let predator: ApexPredator
    
    var body: some View {
        //GeometryReader - this will help with sizing on different devices, using geo var below to get size of the iphone of the user
        GeometryReader { geo in
            //ScrollView - it is used so that content can be scrollable and go below the screen, on the other hand vstack only stays within the screen (not scrollable)
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    //background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                    
                    //dinosaur image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5,
                               height: geo.size.height/3)
                        .scaleEffect(x: -1) //to flip the image on axis (x axis, in this case)
                        .shadow(color: .black, radius: 7) // to add shadow to dino image
                        .offset(y: 20) //to move the image on axis, in this case to give it a 3D effect on y axis 
                }
                //geo return size of the screen on each device (changes as per device)
//                Text("\(geo.size.height)")
//                Text("\(geo.size.width)")
                
                //dino name
                
                //current location
                
                // list of movies
                
                //movie moments
                
                //link to webpage
            }
            .ignoresSafeArea() //to get scrollview all the way up to the screen
        }
    }
}

#Preview {
    PredatorDetailView(predator: Predators().apexPredators[2])
}
