//
//  TwitterClient.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/17/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "7ifS3kucmzuJCgPUESUmnemxO", consumerSecret: "PawObRJuWyB80TKoONp3sJytgjxOtt2lJQP8JfNNVX0pPnrl6v")
    
    var myLoginSuccess: (() -> ())?
    var myLoginFailure: ((Error) -> ())?
    
    func logIn(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        
        myLoginSuccess = success
        myLoginFailure  = failure
        
        deauthorize()
        
        fetchRequestToken(withPath: "https://api.twitter.com/oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitter://oauth") as! URL, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let token = (requestToken?.token)! as String
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
            UIApplication.shared.openURL(url)
        }) { (error: Error?) -> Void in
            print("Error \(error!.localizedDescription)")
            self.myLoginFailure?(error!)
        }
    }
    
    func handleOpenURL(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken , success:{ (accessToken: BDBOAuth1Credential?) -> Void in
            print("I got access token")
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.myLoginSuccess?()
            }, failure: { (error: Error) -> () in
                self.myLoginFailure?(error)
            })
            
        }) { (error: Error?) -> Void in
            print("Error \(error!.localizedDescription)")
            self.myLoginFailure?(error!)
        }
        print(url.description)
    }
    
    
    func homeTimeLine(success: @escaping ([Tweet]) -> () , failure: @escaping (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any) in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any) in
            // print("Account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            
            print("Name: \(user.name)")
            print("Screen name: \(user.screenName)")
            print("Profile image URL: \(user.profileURL)")
            print("Description \(user.description)")
            
        }, failure: {(task: URLSessionDataTask?, error: Error) -> Void in
            
            failure(error)
            
        })
    }
    
    func logOut(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
}



