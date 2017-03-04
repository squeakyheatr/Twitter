//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/27/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var tweetButton: UIButton!
    @IBOutlet var countingLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var composeTextLabel: UITextView!
    var count = 0
    let tweetLimit = 140
    var isReplying: Bool?
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextLabel.delegate = self
        composeTextLabel.becomeFirstResponder()
        print(isReplying)
        if isReplying == true {
            composeTextLabel.text = "@\(tweet.user!.screenName!) "
        }
        count = (composeTextLabel.text?.characters.count)!
        countingLabel.text = "\(tweetLimit - count)"
        countingLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ComposeTweet(_ sender: Any) {
        if isReplying == true {
            TwitterClient.sendReply(text: composeTextLabel.text!, statusID: tweet!.tweetId!, callBack: { (tweet: Tweet?, error: Error?) in
            })
            isReplying = false
        } else {
            TwitterClient.sendTweet(text: composeTextLabel.text!) { (tweet: Tweet?, error: Error?) in
            }
        }
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }

    func textViewDidChange(_ textView: UITextView) {
        count = (composeTextLabel.text?.characters.count)!
        countingLabel.text = "\(tweetLimit - count)"
        if count <= 140 {
            tweetButton.isEnabled = true
            countingLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            tweetButton.isEnabled = false
            countingLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
}
