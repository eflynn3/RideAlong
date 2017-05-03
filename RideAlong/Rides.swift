//
//  Rides.swift
//  RideAlong
//
//  Created by Erin Flynn on 5/3/17.
//
//


import Foundation
import Firebase

class Rides {
    
    private var ridesRef: FIRDatabaseReference!
    
    private var _location: String?
    private var _date: String?
    private var _time: String?
    private var _name: String?
    private var _Key: String?
    private var _type: String?
    
    var type: String {
        return _type!
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
        
        
        if let n = dictionary["name"] as? String {
            self._name = n
        }
        
        if let t = dictionary["type"] as? String {
            self._type = t
        }

        // The above properties are assigned to their key.
        let uid = FIRAuth.auth()?.currentUser!.uid
        self.ridesRef = FIRDatabase.database().reference().child("MyRides").child(uid!).child(self._Key!)
    }
}
