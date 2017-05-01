//
//  OfferRideViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/6/17.
//
//

import UIKit
import Firebase

class OfferRideViewController: UIViewController {

    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var seats: UITextField!
    @IBOutlet weak var date: UIDatePicker!

    
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
                let last = dict["last-name"] as! String!
                self.name = first + " " + last
                self.photo = dict["pic"] as! String
                //let classYear = dict["class"]?.uppercaseString
                //let gender = dict["gender"]?.uppercaseString
                //self.infoLabel.text! = classYear! + " | " + gender!
                //if let profileImageURL = dict["pic"] as? String{
                //    self.profilePic = profileImageURL
                //}
            }
        })

    
    }
    
    @IBAction func handlePublish(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm"
        var strDate = dateFormatter.stringFromDate(self.date.date)
        print(strDate)
        var myStringArr = strDate.componentsSeparatedByString(", ")
        self.dateString = myStringArr[0]
        self.timeString = myStringArr[1]
        
        let itemRef = databaseRef.child("requests").childByAutoId() // 1
        let messageItem = [ // 2
            "sender": self.senderID,
            "name" : self.name,
            "seats": self.seats.text!,
            "date": self.dateString,
            "time": self.timeString,
            "location": self.location.text!,
            "type": "OFFER",
            "photo" : self.photo
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
