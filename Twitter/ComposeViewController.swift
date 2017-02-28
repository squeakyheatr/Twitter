//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/27/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var composeTextLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextLabel.delegate = self
        composeTextLabel.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ComposeTweet(_ sender: Any) {
        TwitterClient.sendTweet(text: composeTextLabel.text!) { (tweet: Tweet?, error: Error?) in
            
        }
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func Cancel(_ sender: Any) {
    navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }


}
