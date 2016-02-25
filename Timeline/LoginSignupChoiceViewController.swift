//
//  LoginSignupChoiceViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignupChoiceViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HelloO")
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let loginOrSignupView = segue.destinationViewController as? LoginSignupViewController
        if segue.identifier == "toLogin" {
            loginOrSignupView?.mode = .LogIn
        } else {
            loginOrSignupView?.mode = .SignUp
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
