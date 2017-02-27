//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/25/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileBackgroundImage: UIImageView!
    @IBOutlet var profileProfileImage: UIImageView!
    @IBOutlet var profileUserNameLabel: UILabel!
    @IBOutlet var profileScreenNameLabel: UILabel!
    @IBOutlet var profileDescriptionLabel: UILabel!
    @IBOutlet var profileNumOfTweetLabel: UILabel!
    @IBOutlet var profileFollowingLabel: UILabel!
    @IBOutlet var profileFollowersLabel: UILabel!
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileBackgroundImage.setImageWith(tweet.user.backgroundImage!)
        profileProfileImage.setImageWith(tweet.user.profileURL!)
        profileUserNameLabel.text = tweet.user.name
        profileScreenNameLabel.text = "@ \(tweet.user.screenName!)"
        profileDescriptionLabel.text = "\(tweet.user.description)"
        profileNumOfTweetLabel.text = "\(tweet.user.numberOfTweets!) Tweets"
        profileFollowersLabel.text = "\(tweet.user.numberOfFollwers!) Followers"
        profileFollowingLabel.text = "\(tweet.user.numberOfFollows!) Following"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
