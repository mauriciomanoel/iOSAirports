//
//  FormView.swift
//  Airports
//
//  Created by Mauricio on 6/17/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit

class FormView: UIView {

    @IBOutlet weak var originStation: ItemWithLabelAndTextField!
    @IBOutlet weak var destinationStation: ItemWithLabelAndTextField!
    @IBOutlet weak var departureDateIn: ItemWithLabelAndSpinner!
    @IBOutlet weak var departureDateOut: ItemWithLabelAndSpinner!
    @IBOutlet weak var passengersAdults: ItemWithLabelAndSpinner!
    @IBOutlet weak var passengersTeen: ItemWithLabelAndSpinner!
    @IBOutlet weak var passengersChildren: ItemWithLabelAndSpinner!
    @IBOutlet weak var loadingView: UIView!
    
    
    var flightInputClosure     : ((FlightInput)->())?
    private var flightInputData: FlightInput = FlightInput() {
        didSet {
            self.flightInputClosure?(flightInputData)
        }
    }
    
    func setupLayout() {
        originStation.setTitle("Origin Station")
        destinationStation.setTitle("Destination Station")
        departureDateIn.setTitle("Departure Date (In)")
        departureDateOut.setTitle("Departure Date (Out)")
        
        passengersAdults.setTitle("Total Adults")
        passengersTeen.setTitle("Total Teens")
        passengersChildren.setTitle("Total Children")
        
        departureDateIn.setupDropdownDateSpinner()
        departureDateOut.setupDropdownDateSpinner()
                
    }
    
    func updateData() {
        originStation.valueTextField.addData()
        destinationStation.valueTextField.addData()
    }
    
    func showLoading() {
        loadingView.isHidden = false
    }
    
    func hideLoading() {
        loadingView.isHidden = true
    }
    
    func setDataPassengersAdults(_ data: [String]) {
        passengersAdults.setupDropdownSpinner(data)
    }
    
    func setDataPassengersTeens(_ data: [String]) {
        passengersTeen.setupDropdownSpinner(data)
    }
    
    func setDataPassengersChildren(_ data: [String]) {
        passengersChildren.setupDropdownSpinner(data)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        let destination = self.destinationStation.valueTextField.text
        let originStation = self.originStation.valueTextField.text
        let dateout = self.departureDateOut.dataTextField.text
        let adt = passengersAdults.dataTextField.text
        let teens = passengersTeen.dataTextField.text
        let chd = passengersTeen.dataTextField.text
        
        guard let _destination = destination else { return }
        guard let _originStation = originStation else { return }
        guard let _dateout = dateout else { return }
        guard let _adt = adt else { return }
        guard let _teens = teens else { return }
        guard let _chd = chd else { return }
        
        var flightInput = FlightInput(destination: _destination, origin: _originStation, dateout: _dateout, adt: _adt, teen: _teens, chd: _chd)
        self.flightInputData = flightInput
    }
    

}
