
//
//  fflight.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

struct FlightInput {
    var destination, origin, dateout, adt, teen, chd: String
    var flexdaysbeforeout, flexdaysout, flexdaysbeforein, flexdaysin, toUs: String
    var roundtrip: Bool

    init(destination: String = "DUB", origin: String = "STN", dateout: String = "2019-01-01", adt: String = "1", teen: String = "0", chd: String = "0", flexdaysbeforeout: String = "3", flexdaysout: String = "3", flexdaysbeforein: String = "3", flexdaysin: String = "3", roundtrip: Bool = false, toUs: String = "AGREED") {
        
        self.destination = destination
        self.origin = origin
        self.dateout = dateout
        self.adt = adt
        self.teen = teen
        self.chd = chd
        self.flexdaysbeforeout = flexdaysbeforeout
        self.flexdaysout = flexdaysout
        self.flexdaysbeforein = flexdaysbeforein
        self.flexdaysin = flexdaysin
        self.toUs = toUs
        self.roundtrip = roundtrip
    }
}
