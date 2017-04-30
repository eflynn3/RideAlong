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
    
    var userRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private var chats: [Chat] = [] // 3
    
    //var with_user: AnyObject
    
    //private lazy var chatRef: FIRDatabaseReference = FIRDatabase.database().reference().child("users")
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
        
       return 2
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selection = indexPath.row
        if selection == 1 {
            //self.observeChannels()
            self.performSegueWithIdentifier("toSpecificChat", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSpecificChat" {
            let destViewController = segue.destinationViewController as! LiveChatViewController
            destViewController.chatUser = "dybNDmCpVfOrURdkk6yePiVbLWJ2" //turley id
        }
    }
    
    override func viewDidAppear( animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! CreateChatCell
        
        cell.toChatName.text = "Erin Turley"
        cell.toChatProfileImage.image = UIImage(named: "erin")
        cell.toChatProfileImage.layer.cornerRadius = cell.toChatProfileImage.frame.size.width/2.2
        cell.toChatProfileImage.clipsToBounds = true
        
        return cell
        
    }


    
}