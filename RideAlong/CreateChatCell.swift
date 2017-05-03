//
//  CreateChatCell.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/25/17.
//
//


import Firebase

import UIKit



class CreateChatCell: UITableViewCell {
    
    @IBOutlet weak var toChatName: UILabel!
    @IBOutlet weak var toChatProfileImage: UIImageView!
    
    
    var chats: Chat!
    var dataRef = FIRDatabase.database().reference()
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func createCell(chat: Chat) {
        self.chats = chat
        
        dataRef.child("users").child(self.chats.otherID).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                if let profileImageURL = dict["pic"] as? String{
                    let url = NSURL(string: profileImageURL)
                    NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) in
                        if error != nil {
                            print(error)
                            return
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.toChatProfileImage?.image = UIImage(data: data!)
                        }
                    }).resume()
                }
            }
        })

        self.toChatName.text = self.chats.name

    }
}