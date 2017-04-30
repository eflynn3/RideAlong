//
//  NewsFeedViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/23/17.
//
//

import UIKit
import Firebase

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let databaseRef = FIRDatabase.database().reference()
    var time: String!
    var date: String!
    var name: String!
    var seats: String!
    var location: String!
    var senderID: String!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsSelection = false

        // Load the sample data.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("NFCell", forIndexPath: indexPath) as! NewsFeedTableCell
        var cellNumber = indexPath.row
        cellNumber = cellNumber + 1
        print(cellNumber)
        getData(cellNumber)
        
        cell.nameText.text = self.name
        cell.postText.text = self.location
        cell.profileImage.image = UIImage(named: "erin")
        cell.date.text = self.date
        cell.time.text = self.time
        cell.datePosted.text = "23 mins ago"
        
        cell.createCell()
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 200.0;//Your custom row height
    }
    
    func getData(cellNumber: Int) {
        
        let uid = FIRAuth.auth()?.currentUser?.uid ?? "nil"
        databaseRef.child("requests").child(String("1")).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                print("IN")
                self.date = dict["data"]?.uppercaseString
                self.time = dict["time"]?.uppercaseString
                self.seats = dict["seats"]?.uppercaseString
                self.senderID = dict["sender"]?.uppercaseString
                self.name = dict["name"]?.uppercaseString
                self.location = dict["location"]?.uppercaseString
            }
        })
    }
    
    
}
