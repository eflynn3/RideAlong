//
//  Chat.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/25/17.
//
//

import Foundation
import Firebase

class Chat {
    
    private var chatsRef: FIRDatabaseReference!
    
    private var _name: String?
    private var _otherID: String?
    private var _Key: String?
    
    
    var name: String {
        return _name!
    }
    
    var otherID: String {
        return _otherID!
    }
    
    var key: String {
        return _Key!
    }
    
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._Key = key
        
        // Within the Joke, or Key, the following properties are children
        
        if let id = dictionary["otherID"] as? String {
            self._otherID = id
        }
        
        if let n = dictionary["name"] as? String {
            self._name = n
        }
        
        // The above properties are assigned to their key.
        let uid = FIRAuth.auth()?.currentUser!.uid
        self.chatsRef = FIRDatabase.database().reference().child("MyChats").child(uid!).child(self._Key!)
    }
}