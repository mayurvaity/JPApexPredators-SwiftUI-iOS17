//
//  Predators.swift
//  JPApexPredators-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 29/06/24.
//

import Foundation

//class to decode JSON data and store converted data into a variable 
class Predators {
    //to keep unchanged list of apex predators 
    var allApexPredators: [ApexPredator] = []
    
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
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data, \(error)")
            }
        }
    }
    
    //fn to search text and return filtered list 
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            //if no text in searchfield then return entire list
            return apexPredators
        } else {
            //if any text in searchfield then filter list using it and return filtered list
            return apexPredators.filter {
                predator in
                //filtering on property name of class ApexPredator
                //localizedCaseInsensitiveContains - to match without case sensitivity
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    //fn to sort the list
    func sort(by alphabetical: Bool) {
        apexPredators.sort { apexPredator1, apexPredator2 in
            if alphabetical {
                //to sort by name of predator
                apexPredator1.name < apexPredator2.name
            } else {
                //to sort by order of appearance in movies
                //id is already given base on order of appearance in movies 
                apexPredator1.id < apexPredator2.id
            }
        }
    }
    
    //fn to filter using drop down menu
    func filter(by type: PredatorType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter({ predator in
                predator.type == type
            })
        }
    }
}
