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
    
    //calculated variable, get triggered by changes in properties used in it (@State var broadcast changes made to it, so it knows)
    var filteredDinos: [ApexPredator] {
        if searchText.isEmpty {
            //if no text in searchfield then return entire list
            return predators.apexPredators
        } else {
            //if any text in searchfield then filter list using it and return filtered list
            return predators.apexPredators.filter {
                predator in
                //filtering on property name of class ApexPredator
                //localizedCaseInsensitiveContains - to match without case sensitivity
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
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
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
