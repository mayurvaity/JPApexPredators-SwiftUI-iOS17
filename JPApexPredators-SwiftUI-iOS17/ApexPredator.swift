//
//  ApexPredator.swift
//  JPApexPredators-SwiftUI-iOS17
//
//  Created by Mayur Vaity on 29/06/24.
//

import Foundation
import SwiftUI

//all the property types should conform to Decodable
//all default property types automatically conform to decodable, but user defined ones need to do manually (in this case MovieScene)
struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    //calculated var to get image name from name property,
    //replacingOccurrences - by replacing spaces with blank and
    //lowercased - lowercasing all charactrers
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
}

//separting this enum from above class so that it can be used by other files directly 
//enum created for getting color in "type" property
//this enum to be used as type above while decoding, hence need to specify type as string below and also need to conform to Decodable
//CaseIterable, Identifiable -  to be able to use in foreach loop
enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    //need an id property to conform to Identifiable protocol 
    var id: PredatorType {
        self
    }
    
    //calculated var to return background color for "type"
    var background: Color {
        switch self {
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        case .all:
                .black
        }
    }
    
    //calculated var to store filter menu icon strings
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
