//
//  FlightsResult.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

// MARK: - FlightsResult
struct FlightsResult: Codable {
    let message: String?
    let code: String?
    let termsOfUse: String?
    let currency: String?
    let currPrecision: Int?
    let routeGroup, tripType, upgradeType: String?
    let trips: [Trip]?
    let serverTimeUTC: String?
    
    init(termsOfUse: String = "", currency: String = "", currPrecision: Int = 0, routeGroup: String = "", tripType: String = "", upgradeType: String = "", trips: [Trip] = [], serverTimeUTC: String = "", message: String = "", code: String = "") {
        
        self.termsOfUse = termsOfUse
        self.currency = currency
        self.currPrecision = currPrecision
        self.routeGroup = routeGroup
        self.tripType = tripType
        self.upgradeType = upgradeType
        self.trips = trips
        self.serverTimeUTC = serverTimeUTC
        self.message = message
        self.code = code

    }
}

// MARK: - Trip
struct Trip: Codable {
    let origin, originName, destination, destinationName: String
    let routeGroup, tripType, upgradeType: String
    let dates: [DateElement]
}

// MARK: - DateElement
struct DateElement: Codable {
    let dateOut: String
}
