//
//  TripTableViewCell.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var originOutput: UILabel!
    @IBOutlet weak var destinationOutput: UILabel!
    @IBOutlet weak var datesOutput: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateLabel(_ trip: Trip) {
        originOutput.text = trip.originName
        destinationOutput.text = trip.destinationName
        var output: [String] = []
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/dd/yyyy"
        
        trip.dates.enumerated().map { (index, element) in
            
            let date = dateFormatterGet.date(from: element.dateOut)
            output.append(dateFormatterPrint.string(from: date!))
        }
            
        datesOutput.text = output.joined(separator: ", ")
    }
    
}
