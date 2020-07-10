//
//  NetworkManager.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

struct NetworkManager{
    
    let route = Router<ApiEndPoint>()
    static let environment : NetworkEnvironment = .production
    
    var headers: Dictionary<String, String> = [:]
    
    init() {
        headers["Content-Type"] = "application/json;charset=UTF-8"
        
    }
    
    func getStations(_ completion : @escaping(_ res : Data?, _ error : String?)->()){
        
        route.request(ApiEndPoint.getStations(headers: headers)) { (data, response, erro) in
            if erro != nil{
                completion(nil, erro!.localizedDescription)
            }else{
                do{
                    if let _data = data{
                        completion(_data, nil)
                    }else{
                        completion(nil, "Connection Problem!")
                    }
                }
            }
        }
    }
    
    func searchFlights(_ query : Dictionary<String, String>, _ completion : @escaping(_ res : Data?, _ error : String?)->()){

        route.request(ApiEndPoint.searchFlights(query: query, headers: headers)) { (data, response, erro) in
            if erro != nil{
                completion(nil, erro!.localizedDescription)
            }else{
                do{
                    if let _data = data{
                        completion(_data, nil)
                    }else{
                        completion(nil, "Connection Problem!")
                    }
                }
            }
        }
    }

    
}
