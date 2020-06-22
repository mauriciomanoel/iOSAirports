//
//  ApiEndPoint.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

// serviços consultados
enum ApiEndPoint{
    case getStations(data : Data = Data(), query: Dictionary<String, String> = [:], path: [String] = [], headers : Dictionary<String, String>)
    case searchFlights(data : Data = Data(), query: Dictionary<String, String> = [:], headers : Dictionary<String, String>)
}

extension ApiEndPoint : EndPointType{
    
    var task: HTTPTask {
        switch self {
        case .getStations(let data, let query, _, let headers):
            return .request(data: data, query: query, headers: headers)
        case .searchFlights(let data, let query, let headers):
            return .request(data: data, query: query, headers: headers)
        }
    }
    
    var httpMethod: HTTPMethod { // Methodos
        switch self {
        case .getStations:
            return .get
        case .searchFlights:
            return .get
        }
    }
    
    var completeURL: URL {
        var url = URL(string: environmentBaseURL)
        switch self {
            case .getStations: url = URL(string: "https://tripstest.ryanair.com/static/stations.json")
            case .searchFlights: url = URL(string: "https://tripstest.ryanair.com/api/v4/Availability")
        }
        
        if let url = url {
            return url
        } else{fatalError("Invalid")}
    }
    
    var environmentBaseURL: String {
        return ""
    }
}

