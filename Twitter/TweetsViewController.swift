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
    var user: User!
    var refreshControl = UIRefreshControl()
    
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
        
        
        self.refreshControl.addTarget(self, action: "didRefreshList", for: .valueChanged )
        tweetsTableView.refreshControl = self.refreshControl
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.130674147, green: 0.6089884724, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        tweetsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell" ) as! TweetTableViewCell
        
        cell.tweet = self.tweets?[indexPath.row]
        cell.delegate = self
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        TwitterClient.sharedInstance?.logOut()
        
    }
    
    func didRefreshList() {
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        tweetsTableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            
            let segCell = sender as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: segCell)
            let segTweetCell = tweets![indexPath!.row]
            
            let detailsVC = segue.destination as! TweetsDetailsViewController
            
            detailsVC.detailTweet = segTweetCell
        } else if segue.identifier == "ProfileSegue" {
            let segVc = sender as! TweetsViewController
            let segCell = segVc.tweetsTableView as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: segCell)
            let segTweetCell = tweets![indexPath!.row]
            let profileVC = segue.destination as! ProfileViewController
            profileVC.tweet = segTweetCell
            
        }
        
    }
    
}

extension TweetsViewController: TweetTableViewCellDelegate{
    func profileImageViewTapped(cell: TweetTableViewCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier:"Profile") as? ProfileViewController
        {
            profileVC.tweet = cell.tweet //set the profile user before your push
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}
