//
//  RequestRideViewController.swift
//  RideAlong
//
//  Created by Erin Turley on 4/29/17.
//
//

import UIKit
import Firebase

class RequestRideViewController: UIViewController {
    var userRef = FIRDatabase.database().reference()
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var passengersField: UITextField!
   
    @IBAction func handlePublish(sender: AnyObject) {
        let location = self.locationField.text!
        let passengers = self.passengersField.text!
    }
    
    override func viewDidAppear( animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let ref = self.userRef.child("requests") // 2
        let Item = []
        ref.setValue(Item) // 4
    }
}
