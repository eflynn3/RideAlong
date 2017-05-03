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
    var type: String!
    
    var posts = [Post]()

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef.child("requests").observeEventType(.Value, withBlock: {(snapshot) in
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots {
                    if let dict = snap.value as? [String: AnyObject]{
                        let key = snap.key
                        
                        let post = Post(key: key, dictionary: dict)
                        self.posts.insert(post, atIndex: 0)
                    }
                }
            }
            self.tableView.reloadData()
            })
        
        
        //observePosts()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.allowsSelection = false
        // Load the sample data.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toChat" {
            let destViewController = segue.destinationViewController as! LiveChatViewController
            destViewController.chatUser = "F0TddlmdRgW98r9NGp5ahceZ2qO2" //turley id
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 2
        return posts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let post = posts[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("NFCell", forIndexPath: indexPath) as! NewsFeedTableCell
        
        cell.createCell(post)
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 170.0;//Your custom row height
    }
    
    private func observePosts() {
        let ref = FIRDatabase.database().reference().child("requests")

        let q = ref.queryLimitedToLast(25)
        
        let newMessageRefHandle = q.observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            let dict = snapshot.value as! Dictionary<String, String>
            let key = snapshot.key
            
            let post = Post(key: key, dictionary: dict)
            self.posts.insert(post, atIndex: 0)
        })
        
        self.tableView.reloadData()
    }

    @IBAction func handleAccept(sender: AnyObject) {

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selection = indexPath.row
        print(selection)
    }
    
    
}
