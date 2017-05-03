//
//  NewsFeedTableCell.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/23/17.
//
//

import UIKit
import Firebase

class NewsFeedTableCell: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var datePosted: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var acceptedButton: UIButton!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var numSeatsLeft: UILabel!
    
    var uid = FIRAuth.auth()?.currentUser?.uid

    var post: Post!
    var dataRef = FIRDatabase.database().reference().child("requests")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        acceptedButton.addTarget(self, action: #selector(self.seatTapped(_:)), forControlEvents: .TouchUpInside)
        chatButton.addTarget(self, action: #selector(self.chatTapped(_:)), forControlEvents: .TouchUpInside)

    }

    func seatTapped(sender: UIButton) {
        if self.post.sender == self.uid! { //cannot accept your own request/offer
            print("in")
            acceptedButton.userInteractionEnabled = false
        }
        else if self.post.seats == "0"{
            acceptedButton.userInteractionEnabled = false
        }
        else {
            self.post.addSubtractSeat(true, type: self.post.type)
        }
    }
    func chatTapped(sender: UIButton){
        if self.post.sender == self.uid! { //cannot chat with yourself
            chatButton.userInteractionEnabled = false
        }
        else {
            self.post.createChat()
        }
    }
    
    func createCell(post: Post) {
        self.post = post
        if let prof = post.photo as? String {
            let url = NSURL(string: prof)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.profileImage?.image = UIImage(data: data!)
                }
            }).resume()
        }
            
        self.nameText.text = post.name

        self.date.text = "on " + post.date
        self.time.text = "at " + post.time
        self.type.text = post.type
        self.numSeatsLeft.text = String(post.seats)
        if post.type == "REQUEST" {
            self.type.backgroundColor = UIColor(colorLiteralRed:0.047, green:0.616, blue:0.616, alpha:1.0)
            self.postText.text = "I want to go to " + post.location
        }
        if post.type == "OFFER" {
            self.type.backgroundColor = UIColor(colorLiteralRed:12/255.0, green:106/255.0, blue:157/255.0, alpha:1.0)
            self.postText.text = "I am going to " + post.location

        }
        self.line.backgroundColor = UIColor.lightGrayColor()
        
        backgroundCardView.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        
        backgroundCardView.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
        
    }
}
