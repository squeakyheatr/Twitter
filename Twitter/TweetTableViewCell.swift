//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/18/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
// look retweeted status is something that someone retweeted

import UIKit
protocol TweetTableViewCellDelegate: class  {
    func profileImageViewTapped(cell: TweetTableViewCell, user: User)
}
class TweetTableViewCell: UITableViewCell {

    @IBOutlet var profilePic: UIImageView! {
        didSet{
            self.profilePic.isUserInteractionEnabled = true //make sure this is enabled
            //tap for userImageView
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.profilePic.addGestureRecognizer(userProfileTap)
        }
    }
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var twitterUserLabel: UILabel!
    @IBOutlet var tweetLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var retweetCountLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var favoriteCountLabel: UILabel!
    weak var delegate: TweetTableViewCellDelegate? //make sure it's weak to prevent retain cycle
 
    
    var isFavorited: Bool = false
    var isRetweeted: Bool = false
    
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            userNameLabel.text = tweet.user.name
            profilePic.setImageWith((tweet.user.profileURL)!)
            twitterUserLabel.text = "@\(tweet.user!.screenName!)"
            timeLabel.text = tweet.timeStampAsString
            
            
            let retweetStr = String(tweet.retweetCount)
            retweetCountLabel.text = retweetStr
            let favoriteString = String(tweet.favoriteCount)
            favoriteCountLabel.text = favoriteString
            
            

            
            if isFavorited == true {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                favoriteCountLabel.text = String(tweet.favoriteCount + 1)
            } else {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                favoriteCountLabel.text = String(tweet.favoriteCount)

            }
            if isRetweeted == true {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                retweetCountLabel.text = String(tweet.retweetCount + 1)

            } else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
                retweetCountLabel.text = String(tweet.retweetCount)

            }

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePic.layer.cornerRadius = 4
        profilePic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func isFavoriting(_ sender: Any) {
        
        if isFavorited == false {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            
            TwitterClient.sharedInstance?.isFavoriting(id: tweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            favoriteCountLabel.text = String(tweet.favoriteCount + 1)
            isFavorited = true
        
        
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            
            TwitterClient.sharedInstance?.isUnfavoriting(id: tweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            
            favoriteCountLabel.text = String(tweet.favoriteCount)
            isFavorited = false
        }
        
    }
    
    @IBAction func isRetweeting(_ sender: Any) {
      
        if isRetweeted == false {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            
            TwitterClient.sharedInstance?.isRetweeting(id: tweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            
            retweetCountLabel.text = String(tweet.retweetCount + 1)
            isRetweeted = true
            
        } else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            
            TwitterClient.sharedInstance?.isUnretweeting(id: tweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            retweetCountLabel.text = String(tweet.retweetCount)
            isRetweeted = false
            
        }
        
    }
    
    func userProfileTapped(_ gesture: UITapGestureRecognizer){
        if let delegate = delegate{
            delegate.profileImageViewTapped(cell: self, user: self.tweet.user)
        }
    }

    

}
