//
//  PredatorDetailView.swift
//  JPApexPredators-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 01/07/24.
//

import SwiftUI
import MapKit

struct PredatorDetailView: View {
    
    //var to store selected predator data
    let predator: ApexPredator
    
    //to accept location values from contentView and store for later use
    @State var position: MapCameraPosition
    
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
                    //NavigationLink - added to make it clickable and to go to another view when clicked
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                        //Map - this view is used to show Apple Maps
                        Map(position: $position) {
                            //to show location on map, with some title
                            Annotation(predator.name, coordinate: predator.location) {
                                //what to show on the map
                                //in this case an pin icon from SF symbols library
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle) //to make pin bigger
                                    .imageScale(.large) //to make pin even bigger
                                    .symbolEffect(.pulse) //to add animation to sf symbol, in this case pulse, looks like active location
                            }
                            .annotationTitles(.hidden)  //to hide the title, in the Annotation view it is compulsory to provide some title value, so need to use this to hide it
                        }
                        .frame(height: 125)
                        //below overlay to add right arrow on the map, to make it appear as clickable
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        //to add current location text on top left corner
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15)) //to curve the right sided corner of the text bg
                        }
                        .clipShape(.rect(cornerRadius: 15))  //another way of making view rounded rectangle
                        
                    }
                    
                    // list of movies
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
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
        .toolbarBackground(.automatic) //to avoid nav bar bug which gets there when map view is added in detail view
    }
}

#Preview {
    //every navigationLink vw needs a navigationstack, otherwise preview wont work, in this app abv navigationlink considers navigationstack of contentvw as its own, so no issues while running app
    //also we cannot add navstack above as when app will run there will b 2 navigationstacks (1 from contentvw and 2 from here), this will cause confusion for the app
    NavigationStack {
        //distance 30000 - camera view to the location provided from how high from the ground
        PredatorDetailView(predator: Predators().apexPredators[10],
                           position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[10].location, distance: 30000)))
        .preferredColorScheme(.dark)
    }
}
