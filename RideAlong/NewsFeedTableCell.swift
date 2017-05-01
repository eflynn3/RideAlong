//
//  NewsFeedTableCell.swift
//  RideAlong
//
//  Created by Erin Flynn on 4/23/17.
//
//

import UIKit

class NewsFeedTableCell: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var datePosted: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var interestedButton: UIButton!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var line: UIView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func createCell(post: Post) {
        
        self.nameText.text = post.name  //this needs to be changed to name
        //self.postText.text = post.location
        self.profileImage.image = UIImage(named: "erin")
        self.date.text = "on " + post.date
        self.time.text = "at " + post.time
        self.type.text = post.type
        
        if post.type == "REQUEST" {
            self.type.backgroundColor = UIColor(colorLiteralRed:0.047, green:0.616, blue:0.616, alpha:1.0)
            self.postText.text = "I want to go to " + post.location
        }
        if post.type == "OFFER" {
            self.type.backgroundColor = UIColor(colorLiteralRed:12/255.0, green:106/255.0, blue:157/255.0, alpha:1.0)
            self.postText.text = "I am going to " + post.location

        }
        self.line.backgroundColor = UIColor.lightGrayColor()
        
        //self.datePosted.text = "23 mins ago"
        backgroundCardView.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        //contentView.backgroundColor = UIColor(colorLiteralRed:0.047, green:0.616, blue:0.616, alpha:1.0)
        
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        
        backgroundCardView.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
        
    }
}
