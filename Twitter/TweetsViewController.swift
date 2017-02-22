//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/17/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var check: Bool = false
    @IBOutlet var tweetsTableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        // Do any additional setup after loading the view.
        //        tweetsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell" ) as! TweetTableViewCell
        
        let tweet = self.tweets?[indexPath.row]
        
        cell.tweetLabel.text = tweet?.text
        cell.userNameLabel.text = tweet?.user?.name
        cell.profilePic.setImageWith((tweet?.user?.profileURL)!)
        cell.timeLabel.text = tweet?.timeStampAsString
        cell.favoriteCountLabel.text = "\(tweet!.favoriteCount)"
        cell.retweetCountLabel.text = "\(tweet!.retweetCount)"
        cell.twitterUserLabel.text = tweet?.user?.screenName
        if tweet?.isFavorited == true {
            cell.favoriteCountLabel.text = "\((tweet?.favoriteCount)! + 1)"
        }

        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func onLogoutButton(_ sender: Any) {
        
        TwitterClient.sharedInstance?.logOut()
        
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
