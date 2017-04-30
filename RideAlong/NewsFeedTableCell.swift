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
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var interestedButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func createCell() {
        backgroundCardView.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        contentView.backgroundColor = UIColor(colorLiteralRed:0.047, green:0.616, blue:0.616, alpha:1.0)
        
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        
        backgroundCardView.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
        
        
        chatButton.layer.cornerRadius = 2
        chatButton.layer.borderWidth = 1
        
        commentButton.layer.cornerRadius = 2
        commentButton.layer.borderWidth = 1
        
        interestedButton.layer.cornerRadius = 2
        interestedButton.layer.borderWidth = 1
        
    }
}
