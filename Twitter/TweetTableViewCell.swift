//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/18/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var twitterUserLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var retweetCountLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var favoriteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
