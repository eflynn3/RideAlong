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
    var profilePic: String!
    var name: String!
    var dateString: String!
    var timeString: String!
    
    func getData() {
        self.senderID = FIRAuth.auth()?.currentUser?.uid
        databaseRef.child("users").child(self.senderID).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                let first = dict["first-name"]?.uppercaseString
                let last = dict["last-name"]?.uppercaseString
                self.name = first! + " " + last!
                //let classYear = dict["class"]?.uppercaseString
                //let gender = dict["gender"]?.uppercaseString
                //self.infoLabel.text! = classYear! + " | " + gender!
                if let profileImageURL = dict["pic"] as? String{
                    self.profilePic = profileImageURL
                }
            }
        })
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle   // You can also use Long, Medium and No style.
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var inputDate = dateFormatter.stringFromDate(date.date)
        print(inputDate)
        
        var myStringArr = inputDate.componentsSeparatedByString(", ")
        self.dateString = myStringArr[0]
        self.timeString = myStringArr[1]

    }

    @IBAction func handlePublish(sender: AnyObject) {
        let itemRef = databaseRef.child("requests").childByAutoId() // 1
        let messageItem = [ // 2
            "sender": self.senderID,
            "name" : self.name,
            "seats": self.numberOfSeats.text!,
            "date": self.dateString,
            "time": self.timeString,
            "location": self.location.text!
        ]
        
        itemRef.setValue(messageItem)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
