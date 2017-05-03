//
//  MyRideCell.swift
//  RideAlong
//
//  Created by Erin Flynn on 5/3/17.
//
//

import UIKit
import Firebase

class MyRideCell: UITableViewCell {

    @IBOutlet weak var typeField: UILabel!
    
    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var locationField: UILabel!
    
    @IBOutlet weak var dayField: UILabel!
    
    @IBOutlet weak var timeField: UILabel!
    
    var rides: Rides!
    var dataRef = FIRDatabase.database().reference().child("requests")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func createCell(rides: Rides) {
        self.rides = rides
        self.nameField.text = "With: " + self.rides.name  //this needs to be changed to name
        self.locationField.text = "Where: " + self.rides.location
        self.dayField.text = "on " + self.rides.date
        self.timeField.text = "at " + self.rides.time
        if self.rides.type == "REQUEST" {
            self.typeField.text = "You accepted an offer"
            self.typeField.backgroundColor = UIColor(colorLiteralRed:0.047, green:0.616, blue:0.616, alpha:1.0) //request
        }
        else {
            self.typeField.text = "You accepted a request"
            self.typeField.backgroundColor = UIColor(colorLiteralRed:12/255.0, green:106/255.0, blue:157/255.0, alpha:1.0)
        }
        
    }

}
