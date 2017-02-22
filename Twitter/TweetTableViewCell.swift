//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/18/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
// look retweeted status is something that someone retweeted

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
    var count = 1
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func isFavoriting(_ sender: Any) {
        
        count += 1
        count = count % 2
        if count == 0{
            self.tweet?.isFavorited = !self.tweet.isFavorited!
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
//            self.tweet?.favoriteCount =  tweet.favoriteCount + 1
            self.favoriteCountLabel.text = "\((tweet?.favoriteCount)! + 1)"
        } else {
            self.tweet?.isFavorited = !self.tweet.isFavorited!
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            self.tweet?.favoriteCount -= 1
            self.favoriteCountLabel.text = "\((tweet?.favoriteCount)! - 1)"
        }
        
    }

}
