//
//  Destination.swift
//  MyDestinations
//
//  Created by Terezija Umiljanovic on 11.05.2021..
//

import UIKit

class Destination: Codable {
    
    static let userDefaultsKey = "DestinationKey"
    
    let id: String
    var title: String
    var shortDescription: String
    
    init(title: String, description: String) {
        self.id = UUID().uuidString
        self.title = title
        self.shortDescription = description
    }

}

