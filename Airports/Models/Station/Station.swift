//
//  Station.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

struct Station: Codable {
    let code, name: String
    let alternateName: String?
    let alias: [String]
    let countryCode, countryName: String
    let countryAlias: String?
    let countryGroupCode: String
    let countryGroupName: String
    let timeZoneCode, latitude, longitude: String
    let mobileBoardingPass: Bool
    let markets: [Market]
    let notices: String?
    let tripCardImageURL: String?
    let ecoFriendly, airportShopping: Bool?

    enum CodingKeys: String, CodingKey {
        case code, name, alternateName, alias, countryCode, countryName, countryAlias, countryGroupCode, countryGroupName, timeZoneCode, latitude, longitude, mobileBoardingPass, markets, notices
        case tripCardImageURL = "tripCardImageUrl"
        case ecoFriendly, airportShopping
    }
}
