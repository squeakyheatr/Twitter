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
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        composeVC!.isReplying = self.isReplying
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

