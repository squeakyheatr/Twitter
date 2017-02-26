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
    var user: User!
    var isRetweeted: Bool?
    var isFavorited: Bool?
    var tweetId: Int?
    var tweetIdString: String?
    
    
    init(dictionary: NSDictionary){
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
            timeStampAsString = Tweet.formatTweetTimeStamp((timeStamp?.timeIntervalSinceNow)!)
            
        }
        isFavorited = (dictionary["favorited"]) as! Bool
        isRetweeted = (dictionary["retweeted"]) as! Bool
        
        tweetId = (dictionary["id"] as? Int) ?? 0
        tweetIdString = "\(tweetId!)"
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    class func formatTweetTimeStamp(_ tweetTimeStamp: TimeInterval) -> String{
        var time = Int(tweetTimeStamp)
        var timeSinceTweet: Int = 0
        var timeLabelCharacter = ""
        
        time = time * -1
        
        
        if(time < 60) {
            timeSinceTweet = time
            timeLabelCharacter = "s"
        } else if ((time/60) <= 60) {
            timeSinceTweet = time / 60
            timeLabelCharacter = "m"
        } else if ((time/60/60) <= 24){
            timeSinceTweet = time/60/60
            timeLabelCharacter = "h"
        } else if((time/60/60/24) <= 365){
            timeSinceTweet = time/60/60/24
            timeLabelCharacter = "d"
        } else if((time/60/60/24/365) <= 1){
            timeSinceTweet = time/60/60/24/365
            timeLabelCharacter = "y"
        }
        
        return("\(timeSinceTweet)\(timeLabelCharacter)")
    }
    
}
