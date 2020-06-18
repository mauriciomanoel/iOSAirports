//
//  AirportsRepository.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

class  AirportsRepository {
    
    let networkManager : NetworkManager = NetworkManager()

    func getStations(_ completion: @escaping (_ res : Data?,_ erro : String?) -> ()) {

        networkManager.getStations() { (data, erro) in
            if erro != nil{
                print(erro!)
                completion(nil,erro!)
            }else{
                if let _data = data {
                    completion(_data,nil)
                    return
                }
                print("ERRO PARSE JSON")
                completion(nil,Warning.parse.rawValue)
            }
        }
    }

//    func getProducts(familyCode: String, _ completion: @escaping (_ res : Data?,_ erro : String?) -> ()) {
//
//        let path = [familyCode]
//
//        networkManager.getProducts(path) { (data, erro) in
//            if erro != nil{
//                print(erro!)
//                completion(nil,erro!)
//            }else{
//                if let _data = data {
//                    completion(_data,nil)
//                    return
//                }
//                print("ERRO PARSE JSON")
//                completion(nil,Warning.parse.rawValue)
//            }
//        }
//    }
//
//    func getGoals(familyCode: String, _ completion: @escaping (_ res : Data?,_ erro : String?) -> ()) {
//
//        let path = [familyCode]
//
//        networkManager.getGoals(path) { (data, erro) in
//            if erro != nil{
//                print(erro!)
//                completion(nil,erro!)
//            }else{
//                if let _data = data {
//                    completion(_data,nil)
//                    return
//                }
//                print("ERRO PARSE JSON")
//                completion(nil,Warning.parse.rawValue)
//            }
//        }
//    }
//    
//    func calculate(_ input: CalculateInput, _ completion: @escaping (_ res : Data?,_ erro : String?) -> ()) {
//        let data = try! JSONEncoder().encode(input)
//        networkManager.calculate(data) { (data, erro) in
//            if erro != nil{
//                print(erro!)
//                completion(nil,erro!)
//            }else{
//                if let _data = data {
//                    completion(_data,nil)
//                    return
//                }
//                print("ERRO PARSE JSON")
//                completion(nil,Warning.parse.rawValue)
//            }
//        }
//    }
////
    func searchFlights(_ flightInput: FlightInput, _ completion: @escaping (_ res : Data?,_ erro : String?) -> ()) {
        var query: Dictionary<String, String> = [:]
        query["origin"] = flightInput.origin
        query["destination"] = flightInput.destination
        query["dateout"] = flightInput.dateout
        query["flexdaysbeforeout"] = flightInput.flexdaysbeforeout
        query["flexdaysout"] = flightInput.flexdaysout
        query["flexdaysbeforein"] = flightInput.flexdaysbeforein
        query["flexdaysin"] = flightInput.flexdaysin
        query["flexdaysin"] = flightInput.flexdaysin
        query["adt"] = flightInput.adt
        query["teen"] = flightInput.teen
        query["chd"] = flightInput.chd
        
        query["roundtrip"] = String(flightInput.roundtrip)
        query["ToUs"] = flightInput.toUs

        

        networkManager.searchFlights(query) { (data, erro) in
            if erro != nil{
                print(erro!)
                completion(nil,erro!)
            }else{
                if let _data = data {
                    completion(_data,nil)
                    return
                }
                print("ERRO PARSE JSON")
                completion(nil,Warning.parse.rawValue)
            }
        }
    }    
}
