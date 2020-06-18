//
//  FlightView.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit

class FlightView: UIView {

    @IBOutlet weak var termOfUseOutput: UILabel!
    @IBOutlet weak var currencyOutput: UILabel!
    @IBOutlet weak var tripTypeOutput: UILabel!
    @IBOutlet weak var upgradeTypeOutput: UILabel!
    @IBOutlet weak var tableViewTrips: UITableView!
    var trips: [Trip] = []
    
    func setupLayout() {
        
        registerTableViewCells()
        
        tableViewTrips.delegate = self
        tableViewTrips.dataSource = self
    }
    
    func updateLabel(_ data: FlightsResult?) {
        
        guard let _data = data else { return }
        
        termOfUseOutput.text = _data.termsOfUse
        currencyOutput.text = _data.currency
        tripTypeOutput.text = _data.tripType
        upgradeTypeOutput.text = _data.upgradeType
        
        if let _trips = _data.trips {
            self.trips = _trips
            tableViewTrips.reloadData()
        }
        
    }
    
    private func registerTableViewCells() {
        let bundle = Bundle(identifier: BUNDLE_IDENTIFIER)
        let tripCell = UINib(nibName: "TripTableViewCell", bundle: bundle)
        self.tableViewTrips.register(tripCell, forCellReuseIdentifier: "TripTableViewCell")
    }
}

extension FlightView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
}

extension FlightView: UITableViewDataSource {

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TripTableViewCell") as? TripTableViewCell {
                var trip = trips[indexPath.row]
                cell.updateLabel(trip)
                return cell
            }

            return UITableViewCell()
        }
}
