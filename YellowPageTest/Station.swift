//
//  Station.swift
//  YellowPageTest
//
//  Created by 商语童 on 2020/10/10.
//

import Foundation

public struct Station {
    var location: String = ""
    var description: String = ""
    var venue: String = ""
    var link: String = ""
    var price: Int = 40
    
    init(location: String, description: String, venue: String, link: String, price: Int) {
        self.location = location
        self.description = description
        self.venue = venue
        self.link = link
        self.price = price
    }
}
