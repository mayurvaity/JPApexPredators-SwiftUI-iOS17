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
    
    var body: some View {
        //List view is lazy 
        List(predators.apexPredators) { predator in
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
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
