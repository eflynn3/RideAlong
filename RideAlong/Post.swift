//
//  Post.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/30/17.
//
//

import Foundation
import Firebase

class Post {
    
    private var postRef: FIRDatabaseReference!
    
    private var _location: String?
    private var _date: String?
    private var _time: String?
    private var _name: String?
    private var _seats: String?
    private var _Key: String?
    private var _type: String?
    private var _photo: String?
    private var _sender: String?
    
    var type: String {
        return _type!
    }

    var sender: String {
        return _sender!
    }
    
    var photo: String {
        return _photo!
    }
    
    var location: String {
        return _location!
    }
    
    var date: String {
        return _date!
    }
    
    var time: String {
        return _time!
    }
    
    var name: String {
        return _name!
    }
    
    var seats: String {
        return _seats!
    }
    
    var key: String {
        return _Key!
    }
    
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._Key = key
        
        // Within the Joke, or Key, the following properties are children
    
        if let loc = dictionary["location"] as? String {
            self._location = loc
        }
        
        if let d = dictionary["date"] as? String {
            self._date = d
        }
        
        if let t = dictionary["time"] as? String {
            self._time = t
        }
        
        if let seat = dictionary["seats"] as? String {
            self._seats = seat
        }
        
        if let n = dictionary["name"] as? String {
            self._name = n
        }
        
        if let t = dictionary["type"] as? String {
            self._type = t
        }
        
        if let p = dictionary["photo"] as? String {
            self._photo = p
        }
        
        if let s = dictionary["sender"] as? String {
            self._sender = s
        }
        // The above properties are assigned to their key.
        
        self.postRef = FIRDatabase.database().reference().child("requests").child(self._Key!)
    }
    
    func addSubtractSeat(subtractSeat: Bool, type: String) {
        
        if subtractSeat {
            if type == "REQUEST" {
                _seats = "0"
            }
            else {
                let temp = Int(_seats!)! - 1
                _seats = String(temp)
            }
        }
        
        // Save the new vote total.
        //print("in")
        postRef.child("seats").setValue(_seats)
        let uid = FIRAuth.auth()?.currentUser!.uid

        let itemRef = FIRDatabase.database().reference().child("MyRides").child(uid!).childByAutoId() // 1
        let messageItem = [ // 2
            "type": String(_type!),
            "name" : String(_name!),
            "date": String(_date!),
            "time": String(_time!),
            "location": String(_location!)
        ]
        
        itemRef.setValue(messageItem)
        
    }
    
    func createChat() {
        let uuid = NSUUID().UUIDString
        let uid = FIRAuth.auth()?.currentUser!.uid
        let itemRef = FIRDatabase.database().reference().child("MyChats").child(uid!).child(self._sender!)
        let item = [
            "name" : String(_name!),
            "otherID" : String(_sender!),
            "chatID" : uuid
            ]
        itemRef.setValue(item)
        
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]{
                let first = dict["first-name"] as? String!
                let last = dict["last-name"] as? String!
                let OtherName = first! + " " + last!
                let itemRef2 = FIRDatabase.database().reference().child("MyChats").child(self._sender!).child(uid!)
                let item2 = [
                    "name" : String(OtherName),
                    "otherID" : String(uid!),
                    "chatID" : uuid
                ]
                itemRef2.setValue(item2)
            }

        })
        

    }
}