//
//  SearchFlightsViewController.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit

class SearchFlightsViewController: UIViewController {

    var flightsResult: FlightsResult?
    
    lazy var mainView: FlightView = {
        return self.view.getView(withId: "mainView") as! FlightView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Resources.titleResultSearch.rawValue
        mainView.setupLayout()
        mainView.updateLabel(flightsResult)
    
    }
    
}
