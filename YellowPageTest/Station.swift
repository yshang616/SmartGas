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
    var regularPrice: String = ""
    var regularPriceInt: Int = 0
    
    init(location: String, description: String, regularPrice: String, regularPriceInt: Int) {
        self.location = location
        self.description = description
        self.regularPrice = regularPrice
        self.regularPriceInt = regularPriceInt
    }
}
