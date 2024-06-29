//
//  ContentView.swift
//  JPApexPredators-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 29/06/24.
//

import SwiftUI

struct ContentView: View {
    //obj to get all predator data
    let predators = Predators()
    //var to store search data
    @State var searchText = ""
    //var to store sorting order
    @State var alphabetical = false
    
    //calculated variable, get triggered by changes in properties used in it (@State vars broadcast changes made to it, so it knows)
    var filteredDinos: [ApexPredator] {
        //sorting the list, everytime var "alphabetical" is changed
        predators.sort(by: alphabetical)
        
        //calling search method in Predators, to get filtered list
        return predators.search(for: searchText)
    }
    
    var body: some View {
        //NavigationStack - to stack new screens above the views within
        NavigationStack {
            //List view is lazy
            List(filteredDinos) { predator in
                //NavigationLink - to make list items clickable and to call another screen (view)
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                    
                } label :{
                    HStack {
                        //dinosour image
                        //shadow - to add shadow around image, color white and of radius 1
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        //alignment - to align all the views within to the leading (left) side
                        VStack(alignment: .leading) {
                            //name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            //type
                            //rawValue - to get string value from enum
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                            
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators") //to add a title to this list
            .searchable(text: $searchText) //to add searchfield above the nav title
            .autocorrectionDisabled() //to disable auto correction in search field
            .animation(.default, value: searchText) //animation to show when changes in "searchText" property are observed
            .toolbar {
                //to add sort button on top left on nav bar
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //to show animation while sort toggling 
                        withAnimation {
                            //to change sorting order property
                            alphabetical.toggle()
                        }
                    } label: {
                        //to set view for button and also to change the view based on selected sort order
//                        if alphabetical {
//                            Image(systemName: "film")
//                        } else {
//                            Image(systemName: "textformat")
//                        }
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical) //to add animation (bounce animation) when button is pressed
                        
                    }
                }
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
