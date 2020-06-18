//
//  Cities.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

struct Countries {
   
    var countryCode: String
    var countryName: String
    var stationCode: String
    var stationName: String

    init(countryCode: String, countryName: String, stationCode: String, stationName: String) {
        self.countryCode = countryCode
        self.countryName = countryName
        self.stationCode = stationCode
        self.stationName = stationName
    }
    
    public func getStringText() -> String{
        return "\(stationName), \(countryName) (\(countryCode))"
    }
    
}
