//
//  User.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/17/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    

    
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var userDescription: String?
    var numberOfTweets: Int?
    var backgroundImage: URL?
    var numberOfFollwers: Int?
    var numberOfFollows: Int?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){

        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }
        let backgroundImageString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundImageString = backgroundImageString {
            backgroundImage = URL(string: backgroundImageString)
        }
        numberOfTweets = dictionary["statuses_count"] as? Int
        numberOfFollows = dictionary["friends_count"] as? Int
        numberOfFollwers = dictionary["followers_count"] as? Int
        
        
        userDescription = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary =  try! JSONSerialization.jsonObject(with: userData, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            if  let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                
                defaults.set(nil, forKey: "currentUserData")
                
            }
            
            defaults.synchronize()
            
        }
        
    }
    
}
