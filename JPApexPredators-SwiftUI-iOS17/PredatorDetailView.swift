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
                    //overlay - to add black gradient near the bottom of the image
                        .overlay {
                            LinearGradient(stops: [
                                //clear gradient to show bg image
                                //location - 0.8 means it starts fading at 80% down
                                Gradient.Stop(color: .clear, location: 0.8),
                                //black gradient for continuity effect
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
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
                
                //alignment -  to set alignment of views within this vstack
                VStack(alignment: .leading) {
                    //dino name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    //current location
                    
                    // list of movies
                    Text("Appears In:")
                        .font(.title3)
                    
                    //\.self - to set movie name as id, as we cannot make string list identifiable
                    ForEach(predator.movies, id: \.self) {
                        movie in
                        Text("• " + movie)
                            .font(.subheadline)
                    }
                    
                    //movie moments
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 15) //to add top padding 15
                        
                    ForEach(predator.movieScenes) {
                        scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1) //vertical - to add padding abv and below the text
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    //link to webpage
                    Text("Read More:")
                        .font(.caption)
                    
                    //link - this view opens provided URL into Safari browser
                    Link(predator.link,
                         destination: URL(string: predator.link)!)
                    .font(.caption)
                    .foregroundStyle(Color(.blue))
                    
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width,
                       alignment: .leading) //to set width of the vstack, and alignment of the vstack
//                .border(.blue)
                
            }
            .ignoresSafeArea() //to get scrollview all the way up to the screen
        }
    }
}

#Preview {
    PredatorDetailView(predator: Predators().apexPredators[10])
        .preferredColorScheme(.dark)
}
