//
//  SearchItem.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

class CountrySearchItem {
    var attributedCountryCode: NSMutableAttributedString?
    var attributedCountryName: NSMutableAttributedString?
    var attributedStationCode: NSMutableAttributedString?
    var attributedStationName: NSMutableAttributedString?
    var allAttributedName : NSMutableAttributedString?
    
    var countryCode: String
    var countryName: String
    var stationCode: String
    var stationName: String
    
    public init(countryCode: String, countryName: String, stationCode: String, stationName: String) {
        self.countryCode = countryCode
        self.countryName = countryName
        self.stationCode = stationCode
        self.stationName = stationName
    }
    
    public func getFormatedText() -> NSMutableAttributedString{
        allAttributedName = NSMutableAttributedString()
                
        allAttributedName!.append(attributedStationName!)
        allAttributedName!.append(NSMutableAttributedString(string: ", "))
        allAttributedName!.append(attributedCountryName!)
        allAttributedName!.append(NSMutableAttributedString(string: " ("))
        allAttributedName!.append(attributedCountryCode!)
        allAttributedName!.append(NSMutableAttributedString(string: ")"))

        return allAttributedName!
    }
    
    public func getStringText() -> String{
        return "\(stationName), \(countryName) (\(countryCode))"
    }

}
