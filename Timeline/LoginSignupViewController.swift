//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

enum ViewMode {
    case SignUp
    case LogIn
}

class LoginSignupViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var mode: ViewMode = .SignUp
    

    
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .SignUp:
                guard let user = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return false }
                return !user.isEmpty && !email.isEmpty && !password.isEmpty
            case .LogIn:
                guard let email = emailTextField.text, let password = passwordTextField.text else { return false }
                return !email.isEmpty && !password.isEmpty
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Action Functions
    
    @IBAction func actionButtonTapped(sender: UIButton) {
        if fieldsAreValid {
            switch mode {
            case .LogIn:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (wasSuccesful, user) -> Void in
                    if wasSuccesful {
                        self.navigationController?.popViewControllerAnimated(true)
                        UserController.sharedInstance.currentUserVar = user
                    } else {
                        self.createAlert()
                    }
                    
                })
            case .SignUp:
                UserController.createUser(emailTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: URLTextField.text, completion: { (wasSuccesful, user) -> Void in
                    if wasSuccesful {
                        self.navigationController?.popViewControllerAnimated(true)
                        UserController.sharedInstance.currentUserVar = user
                    } else {
                        self.createAlert()
                    }
                    
                })
            }
        } else {
            self.createAlert()
        }
    }
    
    
    
    // MARK: - Updating Functions
    
    func updateViewBasedOnMode() {
        switch mode {
        case .LogIn:
            usernameTextField.hidden = true
            bioTextField.hidden = true
            URLTextField.hidden = true
            actionButton.setTitle("Sign In", forState: .Normal)
            
        case .SignUp :
            actionButton.setTitle("Sign Up", forState: .Normal)
        }
        
    }
    
    
    // MARK: - Alerts
    
    func createAlert() {
        var title : String
        var message: String
        
        switch mode {
        case .SignUp:
            title = "Invalid Sign Up"
            message = "Enter Valid Parameters"
        case .LogIn:
            title = "Invalid Login"
            message = "Check Credentials"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Try Again", style: .Default, handler: nil)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
