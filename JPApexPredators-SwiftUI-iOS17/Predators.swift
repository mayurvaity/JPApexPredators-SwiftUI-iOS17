//
//  Predators.swift
//  JPApexPredators-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 29/06/24.
//

import Foundation

class Predators {
    //an array to store apexPredators from JSON data (after converting in our swift obj)
    var apexPredators: [ApexPredator] = []
    
    //init fn runs right when a new instance of class is created (in this case "Predators" class)
    init() {
        //in this fn, we are calling below fn to decode data, as we will need JSON data to be decoded right when we create obj of this class 
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        //getting JSON data file using main bundle url
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                //to get data from abv provided url (JSON file url)
                let data = try Data(contentsOf: url)
                //creating a decoder obj (to use later)
                let decoder = JSONDecoder()
                //setting change in cases of property names
                //in data there is snake case, we are using camel case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //decoding "data" and storing into abv created array of objs
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
                
            } catch {
                print("Error decoding JSON data, \(error)")
            }
        }
    }
}
