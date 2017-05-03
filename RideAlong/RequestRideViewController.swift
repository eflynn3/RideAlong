//
//  RequestRideViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/30/17.
//
//

import UIKit
import Firebase

class RequestRideViewController: UIViewController {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var numberOfSeats: UITextField!
    @IBOutlet weak var location: UITextField!
    
    var senderID: String!
    var databaseRef = FIRDatabase.database().reference()
    var photo: String!
    var name: String!
    var dateString: String!
    var timeString: String!
    
    func getData() {
        self.senderID = FIRAuth.auth()?.currentUser?.uid
        databaseRef.child("users").child(self.senderID).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                let first = dict["first-name"] as! String!
                let last = dict["last-name"] as! String
                self.name = first + " " + last
                self.photo = dict["pic"] as! String
            }
        })

    }

    @IBAction func handlePublish(sender: AnyObject) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm a"
        var strDate = dateFormatter.stringFromDate(self.date.date)
        print(strDate)
        var myStringArr = strDate.componentsSeparatedByString(", ")
        self.dateString = myStringArr[0]
        self.timeString = myStringArr[1]
        
        let itemRef = databaseRef.child("requests").childByAutoId() // 1
        let messageItem = [ // 2
            "sender": self.senderID,
            "name" : self.name,
            "seats": self.numberOfSeats.text!,
            "date": self.dateString,
            "time": self.timeString,
            "location": self.location.text!,
            "type": "REQUEST",
            "photo": self.photo
        ]
        
        itemRef.setValue(messageItem)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
