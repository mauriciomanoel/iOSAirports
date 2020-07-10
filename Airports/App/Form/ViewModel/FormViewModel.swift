//
//  FormViewModel.swift
//  Airports
//
//  Created by Mauricio on 6/17/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

class FormViewModel {

    let repository : AirportsRepository
    var flightsResult: FlightsResult?
    var countries : [Countries] = []

    var isLoadingClosure : ((Bool)->())?
    private var isLoading: Bool = false {
        didSet {
            self.isLoadingClosure?(isLoading)
        }
    }
    
    var showErrorMessageClosure: ((String)->())?
    private var errorMessageData: String = "" {
        didSet {
            self.showErrorMessageClosure?(errorMessageData)
        }
    }
    
    var loadParametersClosure     : ((Bool)->())?
    private var loadParametersData: Bool = false {
        didSet {
            self.loadParametersClosure?(loadParametersData)
        }
    }
    
    var passengersAdultsClosure     : (([String])->())?
    private var passengersAdultsData: [String] = [String]() {
        didSet {
            self.passengersAdultsClosure?(passengersAdultsData)
        }
    }
    
    var passengersTeensClosure     : (([String])->())?
    private var passengersTeensData: [String] = [String]() {
        didSet {
            self.passengersTeensClosure?(passengersTeensData)
        }
    }
    
    var passengersChildrenClosure     : (([String])->())?
    private var passengersChildrenData: [String] = [String]() {
        didSet {
            self.passengersChildrenClosure?(passengersChildrenData)
        }
    }
    
    var flightsClosure     : ((FlightsResult)->())?
    private var flightsData: FlightsResult = FlightsResult() {
        didSet {
            self.flightsClosure?(flightsData)
        }
    }
    
    init() {
        self.repository  = AirportsRepository()
    }
    
    
    func loadParameters() {
        self.isLoading = true
        
        var adults: [String] = []
        for index in 1...6 {
            adults.append("\(index)")
        }
        self.passengersAdultsData = adults

        var teens: [String] = []
        for index in 0...6 {
            teens.append("\(index)")
        }
        self.passengersTeensData = teens

        var children: [String] = []
        for index in 0...6 {
            children.append("\(index)")
        }
        self.passengersChildrenData = children
        
        loadStations()
    }
    
    private func loadStations() {
        
        self.repository.getStations() { (data, error) in
            self.isLoading = false
            if error != nil{
                self.errorMessageData = Warning.error.rawValue
            }
            do{
                if (data != nil) {
                    let stationResult = try? JSONDecoder().decode(StationResult.self, from: data!)

                    guard let _stationResult = stationResult else {
                        print("ERROR")
                        return
                    }
                    
                    self.processStations(data: _stationResult)
                }
            }
        }
    }
    
    private func processStations(data: StationResult) {

        countries.removeAll()
        
        for station in data.stations {
            let country = Countries(countryCode: station.countryCode, countryName: station.countryName, stationCode: station.code, stationName: station.name)
            countries.append(country)
        }
        
        AppController.countriesList = countries
        loadParametersData = true

    }
    
    func searchFlights(_ data: FlightInput) {
        
        var flightInput = data
        
        if (flightInput.origin.count == 0) {
            self.errorMessageData = "Origin field is null or invalid"
            return
        }
        
        if (flightInput.destination.count == 0) {
            self.errorMessageData = "Destination field is null or invalid"
             return
        }
        
        if (flightInput.dateout.count < 10) {
            self.errorMessageData = "Date Output field is null or invalid"
            return
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"

        let date = dateFormatterGet.date(from: flightInput.dateout)
        flightInput.dateout = dateFormatterPrint.string(from: date!)
        
        if let i = countries.firstIndex(where: { $0.getStringText() == data.origin }) {
            flightInput.origin = countries[i].stationCode
        } else {
            self.errorMessageData = "Origin field is null or invalid"
            return
        }
        
        if let i = countries.firstIndex(where: { $0.getStringText() == data.destination }) {
            flightInput.destination = countries[i].stationCode
        } else {
            self.errorMessageData = "Destination field is null or invalid"
            return
        }
        self.isLoading = true
        self.repository.searchFlights(flightInput) { (data, error) in
            self.isLoading = false
            if error != nil{
                self.errorMessageData = Warning.error.rawValue
            }
            do{
                if (data != nil) {
                    let flightsResult = try? JSONDecoder().decode(FlightsResult.self, from: data!)

                    guard let _flightsResult = flightsResult else {
                        print("ERROR")
                        self.errorMessageData = Warning.error.rawValue
                        return
                    }
                    
                    if let error = _flightsResult.message  {
                        self.errorMessageData = error
                        return
                    }
                    
                    self.processFlights(data: _flightsResult)
                }
            }
        }
        
    }
    
    private func processFlights(data: FlightsResult) {
        self.flightsData = data
        self.flightsResult = data
    }
    
}
