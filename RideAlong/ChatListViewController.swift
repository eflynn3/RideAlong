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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }

    //WE NEED THIS FUNCTION WHEN WE HAVE CHATS IN THE DATABASE
    /*func getCurrentUserInfo() {
        profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        let uid = FIRAuth.auth()?.currentUser?.uid ?? "nil"
        databaseRef.child("users").child(uid).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                let first = dict["first-name"]?.uppercaseString
                let last = dict["last-name"]?.uppercaseString
                self.nameLabel.text! = first! + " " + last!
                let classYear = dict["class"]?.uppercaseString
                let gender = dict["gender"]?.uppercaseString
                self.infoLabel.text! = classYear! + " | " + gender!
                if let profileImageURL = dict["pic"] as? String{
                    let url = NSURL(string: profileImageURL)
                    NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) in
                        if error != nil {
                            print(error)
                            return
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.profilePic?.image = UIImage(data: data!)
                        }
                    }).resume()
                }
            }
        })
    }*/
    
    // MARK: Properties
    
    var senderDisplayName: String? // 1
    
    var newChatTextField: UITextField? // 2
    
    private var chats: [Chat] = [] // 3
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
        
       return 2
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selection = indexPath.row
        if selection == 1 {
            self.performSegueWithIdentifier("toSpecificChat", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSpecificChat" {
            let destViewController = segue.destinationViewController as! LiveChatViewController
            destViewController.chatUser = "Erin Flynn"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! CreateChatCell
        
        cell.toChatName.text = "Erin Flynn"
        cell.toChatProfileImage.image = UIImage(named: "erin")
        cell.toChatProfileImage.layer.cornerRadius = cell.toChatProfileImage.frame.size.width/2.2
        cell.toChatProfileImage.clipsToBounds = true
        return cell
        
    }
    
    override func viewDidAppear( animated: Bool) {
        
        super.viewDidAppear(animated)
        
        chats.append(Chat(id: "1", name: "Channel1"))
        
        chats.append(Chat(id: "2", name: "Channel2"))
        
        chats.append(Chat(id: "3", name: "Channel3"))
        
        //self.tableView.reloadData()
        
    }
    
}