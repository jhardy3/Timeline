//
//  UserController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


class UserController {
    
    private let kUser = "user"
    
    // MARK: - Properties
    
    var currentUserVar: User? {
        get {
            guard let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String : AnyObject], let identifier = userDictionary["identifier"] as? String else {
                return nil
            }
            
            return User(json: userDictionary, identifier: identifier)
            
        }
        
        set {
            if let user = newValue {
                NSUserDefaults.standardUserDefaults().setValue(user.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            
        }
    }
    
    static let sharedInstance = UserController()
    
    // MARK: - Static Functions
    
    // Returns a User in a completion block based on a query with passed in identifier
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndPoint(identifier) { (data) -> Void in
            guard let data = data as? [String : AnyObject] else { return }
            guard let user = User(json: data, identifier: identifier) else { completion(user: nil) ; return }
            completion(user: user)
        }
    }
    
    // Returns all users in a completion block
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        guard let user = UserController.sharedInstance.currentUserVar else { completion(users: []) ; return }
        FirebaseController.dataAtEndPoint(user.endpoint) { (data) -> Void in
            guard let userDictionaries = data as? [[String : AnyObject]] else { return }
            var users = [User]()
            for dictionary in userDictionaries {
                guard let uid = dictionary["uid"] as? String else { return }
                if let user = User(json: dictionary, identifier: uid) {
                    users.append(user)
                }
            }
        }
    }
    
    // Function allows a User to Follow another User
    static func followUser(user: User, completion: (wasSuccesful: Bool) -> Void) {
        guard let loggedInUser = UserController.sharedInstance.currentUserVar else { completion(wasSuccesful: false) ; return }
        let ref = FirebaseController.firebase.childByAppendingPath("users/\(loggedInUser)/follows/\(user.identifier)")
        ref.setValue(true)
        completion(wasSuccesful: true)
    }
    
    // Alternatively unfollows a user
    static func unfollowUser(user: User, completion: (wasSuccesful: Bool) -> Void) {
        guard let loggedInUser = UserController.sharedInstance.currentUserVar else { completion(wasSuccesful: false) ; return }
        let ref = FirebaseController.firebase.childByAppendingPath("users/\(loggedInUser)/follows/\(user.identifier)")
        ref.setValue(false)
        completion(wasSuccesful: true)
    }
    
    // Checks to see if a user is following another user
    static func userFollowsUser(userOne: User, userTwo: User, completion: (isFollowing: Bool) -> Void) {
        let ref = FirebaseController.firebase.childByAppendingPath("users/\(userOne.identifier)/follows/\(userTwo.identifier)")
        ref.observeSingleEventOfType(.Value, withBlock: { (data) -> Void in
            if let bool = data.value as? Bool {
                if bool == true {
                    completion(isFollowing: true)
                    return
                } else {
                    completion(isFollowing: false)
                    return
                }
            } else {
                completion(isFollowing: false)
            }
        })
    }
    
    // Shows wh0 is is following a user
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        guard let loggedInUser = UserController.sharedInstance.currentUserVar else { completion(users: nil) ; return }
        let ref = FirebaseController.firebase.childByAppendingPath("users/\(loggedInUser.identifier)/follows/")
        ref.observeSingleEventOfType(.Value, withBlock: { (data) -> Void in
            guard let identifierDictionary = data.value as? [[String : AnyObject]] else { return }
            var users = [User]()
            let identifiers = identifierDictionary.flatMap { $0.keys }
            for identifier in identifiers {
                userForIdentifier(identifier, completion: { (user) -> Void in
                    if let user = user {
                        users.append(user)
                    }
                })
            }
        })
    }
    
    // Check to see if a user is actually relevant when loggin in
    static func authenticateUser(email: String, password: String, completion: (wasSuccesful: Bool, user: User?) -> Void) {
        FirebaseController.firebase.authUser(email, password: password) { (error, authData) -> Void in
            if let error = error {
                print(error.localizedDescription)
                completion(wasSuccesful: false, user: nil)
                return
            }
            
            guard let uid = authData.uid else { completion(wasSuccesful: false, user: nil) ; return }
            userForIdentifier(uid, completion: { (user) -> Void in
                guard let user = user else { completion(wasSuccesful: false, user: nil) ; return }
                UserController.sharedInstance.currentUserVar = user
                completion(wasSuccesful: true, user: user)
            })
        }
    }
    
    // Creates a new user if valid information inputed
    static func createUser(email: String, password: String, bio: String?, url: String?, completion: (wasSuccesful: Bool, user: User?) -> Void) {
        FirebaseController.firebase.createUser(email, password: password, withValueCompletionBlock:  { (error, userDictionary) -> Void in
            if let error = error {
                print(error.localizedDescription)
                completion(wasSuccesful: false, user: nil)
            }
            if let uid = userDictionary["uid"] as? String {
                var user = User(username: email, identifier: uid, bio: bio, url: url)
                UserController.sharedInstance.currentUserVar = user
                user.save()
                completion(wasSuccesful: true, user: user)
            } else {
                completion(wasSuccesful: false, user: nil)
            }
        })
        
    }
    
    // Updates the current User
    static func updateUser(user: User, username: String, bio: String?, completion: (wasSuccesful: Bool) -> Void) {
        if let bio = bio {
            
            var newUser = User(username: username, identifier: user.identifier, bio: bio, url: "Hiiiii")
            newUser.save()
            UserController.userForIdentifier(newUser.identifier!, completion: { (user) -> Void in
                UserController.sharedInstance.currentUserVar = user
            })
            completion(wasSuccesful: true)
        }
    }
    
    // logs the current User out
    static func logUserOut() {
        FirebaseController.firebase.unauth()
        self.sharedInstance.currentUserVar = nil
    }
    
    // Mock Users Array
    
    
    
    
    
    
    
}