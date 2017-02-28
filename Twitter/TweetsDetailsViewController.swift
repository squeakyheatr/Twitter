//
//  TweetsDetailsViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/24/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class TweetsDetailsViewController: UIViewController {

    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var detailsUserNameLabel: UILabel!
    @IBOutlet var detailsScreenNameLabel: UILabel!
    @IBOutlet var detailsTweetLabel: UILabel!
    @IBOutlet var detailsTimeStampLabel: UILabel!
    @IBOutlet var detailsRetweetCountLabel: UILabel!
    @IBOutlet var detailsFavoriteCountLabel: UILabel!
    @IBOutlet var detailsFavoriteButton: UIButton!
    @IBOutlet var detailsRewteetButton: UIButton!
    @IBOutlet var detailsReplyButton: UIButton!
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
