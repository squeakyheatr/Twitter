//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/17/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    var check: Bool = false
    @IBOutlet var tweetsTableView: UITableView!
    var tweets: [Tweet]!
    var user: User!
    var refreshControl = UIRefreshControl()

    var isMoreDataLoading = false
    var loadingMoreView: InifinteScrollActivityView?
    var id: Int!
    
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
        
        
        let frame = CGRect(x: 0, y: tweetsTableView.contentSize.height, width: tweetsTableView.bounds.size.width, height: InifinteScrollActivityView.defaultHeight)
        loadingMoreView = InifinteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tweetsTableView.addSubview(loadingMoreView!)
        
        var insets = tweetsTableView.contentInset;
        insets.bottom += InifinteScrollActivityView.defaultHeight;
        tweetsTableView.contentInset = insets
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
        if self.tweets != nil {
            return self.tweets.count
        } else {
            return 0
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
            let scrollViewContentHeight = tweetsTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tweetsTableView.bounds.size.height
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tweetsTableView.isDragging) {
                
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: tweetsTableView.contentSize.height, width: tweetsTableView.bounds.size.width, height: InifinteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                self.id = self.tweets[self.tweets.count - 1].tweetId!
                
                loadMoreData()
            }
        }
        
    }
    
    func loadMoreData() {
        
        TwitterClient.sharedInstance?.loadMoreTweets(id: id, success: { (tweets: [Tweet]) in
            
            for tweet in tweets {
                self.tweets?.append(tweet)
                
            }
            self.loadingMoreView!.stopAnimating()
            self.isMoreDataLoading = false
            self.tweetsTableView.reloadData()
            
        }, failure: {
            
            (error: Error) in
            
            print(error)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            
            let segCell = sender as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: segCell)
            let segTweetCell = tweets![indexPath!.row]
            
            let detailsVC = segue.destination as! TweetsDetailsViewController
            
            detailsVC.detailTweet = segTweetCell
            detailsVC.isFavorited = segTweetCell.isFavorited!
            detailsVC.isRetweeted = segTweetCell.isRetweeted!
            
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
