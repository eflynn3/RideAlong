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
    
    var type: String {
        return _type!
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
        // The above properties are assigned to their key.
        
        self.postRef = FIRDatabase.database().reference().child("requests").child(self._Key!)
    }
    
    /*func addSubtractVote(addVote: Bool) {
        
        if addVote {
            _jokeVotes = _jokeVotes + 1
        } else {
            _jokeVotes = _jokeVotes - 1
        }
        
        // Save the new vote total.
        
        _jokeRef.childByAppendingPath("votes").setValue(_jokeVotes)
        
    }*/
}