//
//  TweetsDetailsViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/24/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class TweetsDetailsViewController: UIViewController {
    
    @IBOutlet var profilePic: UIImageView! {
        didSet{
            self.profilePic.isUserInteractionEnabled = true //make sure this is enabled
            //tap for userImageView
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.profilePic.addGestureRecognizer(userProfileTap)
        }
    }
    @IBOutlet var detailsUserNameLabel: UILabel!
    @IBOutlet var detailsScreenNameLabel: UILabel!
    @IBOutlet var detailsTweetLabel: UILabel!
    @IBOutlet var detailsTimeStampLabel: UILabel!
    @IBOutlet var detailsRetweetCountLabel: UILabel!
    @IBOutlet var detailsFavoriteCountLabel: UILabel!
    @IBOutlet var detailsFavoriteButton: UIButton!
    @IBOutlet var detailsRewteetButton: UIButton!
    @IBOutlet var detailsReplyButton: UIButton!
    var isFavorited = false
    var isRetweeted = false
    var isReplying = true
    var detailTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.setImageWith((detailTweet.user.profileURL)!)
        detailsUserNameLabel.text = detailTweet.user.name
        detailsScreenNameLabel.text = ("@\(detailTweet.user.screenName!)")
        detailsTweetLabel.text = detailTweet.text
        detailsTimeStampLabel.text = detailTweet.timeStampAsString
        detailsRetweetCountLabel.text = "\(detailTweet.retweetCount)"
        detailsFavoriteCountLabel.text = "\(detailTweet.favoriteCount)"
        profilePic.layer.cornerRadius = 4
        profilePic.clipsToBounds = true
        
        if isFavorited == true {
            detailsFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            detailsFavoriteCountLabel.text = String(detailTweet.favoriteCount)
        } else {
            detailsFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            detailsFavoriteCountLabel.text = String(detailTweet.favoriteCount)
            
        }
        if isRetweeted == true {
            detailsRewteetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            
        } else {
            detailsRewteetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func isFavoriting(_ sender: Any) {
        if isFavorited == false {
            detailsFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            
            TwitterClient.sharedInstance?.isFavoriting(id: detailTweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            detailsFavoriteCountLabel.text = String(detailTweet.favoriteCount + 1)
            isFavorited = true
            
            
        } else {
            detailsFavoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            
            TwitterClient.sharedInstance?.isUnfavoriting(id: detailTweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            
            detailsFavoriteCountLabel.text = String(detailTweet.favoriteCount)
            isFavorited = false
        }
        
    }
    
    @IBAction func isRetweeting(_ sender: Any) {
        
        if isRetweeted == false {
            detailsRewteetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            
            TwitterClient.sharedInstance?.isRetweeting(id: detailTweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            
            detailsRetweetCountLabel.text = String(detailTweet.retweetCount + 1)
            isRetweeted = true
            
        } else {
            detailsRewteetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            
            TwitterClient.sharedInstance?.isUnretweeting(id: detailTweet.tweetIdString!, success: { (tweets:[Tweet]) in
            }, failure: { (error: Error) in
            })
            detailsRetweetCountLabel.text = String(detailTweet.retweetCount)
            isRetweeted = false
            
        }
        
    }
    
    
    @IBAction func goHome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func userProfileTapped(_ gesture: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier:"Profile") as? ProfileViewController
        {
            profileVC.tweet = detailTweet //set the profile user before your push
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "isReply"{
            let composeVC = segue.destination as? ComposeViewController
            composeVC!.tweet = self.detailTweet
            composeVC!.isReplying = isReplying
            print("i am passing data")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

