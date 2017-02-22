//
//  Tweet.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/17/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timeStamp: Date?
    var timeStampAsString: String?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var user: User?
//    var retweetCountString: String?
//    var favoriteCountString: String?
    var isRetweeted: Bool?
    var isFavorited: Bool?
    var tweetId: Int?
    var tweetIdString: String?
    
    
    init(dictionary: NSDictionary){
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
//        retweetCountString = "\(retweetCount)"
//        favoriteCountString = "\(favoriteCount)"
        
        let timeStampString = dictionary["created_at"] as? String

        if let timeStampString = timeStampString {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
            timeStampAsString = formatter.string(from: timeStamp!)
            
        }
        isFavorited = (dictionary["favorited"]) as! Bool
        print(isFavorited)
        
        tweetId = (dictionary["id"] as! Int)
        tweetIdString = "\(tweetId)"
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }

}
