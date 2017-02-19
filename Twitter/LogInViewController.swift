//
//  LogInViewController.swift
//  Twitter
//
//  Created by Robert Mitchell on 2/15/17.
//  Copyright © 2017 Robert Mitchell. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LogInViewController: UIViewController {

    @IBOutlet var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogInButtong(_ sender: Any) {
        
        TwitterClient.sharedInstance?.logIn(success: { () -> () in
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }) { (error: Error) in
            print("Error : \(error.localizedDescription)")
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
