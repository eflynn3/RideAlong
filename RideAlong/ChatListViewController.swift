//
//  ChatListViewController.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/25/17.
//
//

import UIKit
import Firebase


class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userRef = FIRDatabase.database().reference()
    var chats = [Chat]()
    
    var chatID: String!
    var chatName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        observeChats()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    // MARK: Properties
    
    let databaseRef = FIRDatabase.database().reference()

    var senderDisplayName: String? // 1
    
    var newChatTextField: UITextField? // 2
    
    //private var chats: [Chat] = [] // 3
    
    //var with_user: AnyObject
    
    //private lazy var chatRef: FIRDatabaseReference = FIRDatabase.database().reference().child("users")
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
        
       return chats.count
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selection = indexPath.row
        self.chatID = chats[selection].otherID
        self.chatName = chats[selection].name
        self.performSegueWithIdentifier("toSpecificChat", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSpecificChat" {
            let destViewController = segue.destinationViewController as! LiveChatViewController
            destViewController.chatUser = self.chatID
            destViewController.otherName = self.chatName
        }
    }
    
    override func viewDidAppear( animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]

        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! CreateChatCell
        
        cell.createCell(chat)
        return cell
    }

    private func observeChats() {
        let uid = FIRAuth.auth()?.currentUser!.uid
        let ref = FIRDatabase.database().reference().child("MyChats").child(uid!)
        
        ref.observeEventType(.Value, withBlock: {(snapshot) in
            self.chats = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots {
                    if let dict = snap.value as? [String: AnyObject]{
                        let key = snap.key
                        
                        let chat = Chat(key: key, dictionary: dict)
                        self.chats.insert(chat, atIndex: 0)
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }
    
}