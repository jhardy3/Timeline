//
//  UserController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


class UserController {
    
    // MARK: - Properties
    
    var currentUser: User! = nil
    
    static let sharedInstance = UserController()
    
    // MARK: - Static Functions
    
    // Returns a User in a completion block based on a query with passed in identifier
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        
    }
    
    // Returns all users in a completion block
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        
    }
    
    // Function allows a User to Follow another User
    static func followUser(user: User, completion: (wasSuccesful: Bool) -> Void) {
        
    }
    
    // Alternatively unfollows a user
    static func unfollowUser(user: User, completion: (wasSuccesful: Bool) -> Void) {
        
    }
    
    // Checks to see if a user is following another user
    static func userFollowsUser(userOne: User, userTwo: User, completion: (isFollowing: Bool) -> Void) {
        
    }
    
    // Shows wh0 is is following a user
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        
    }
    
    // Check to see if a user is actually relevant when loggin in
    static func authenticateUser(email: String, password: String, completion: (wasSuccesful: Bool) -> Void) {
        
    }
    
    // Creates a new user if valid information inputed
    static func createUser(email: String, password: String, bio: String?, url: String?, completion: (wasSuccesful: Bool) -> Void) {
        
    }
    
    // Updates the current User
    static func updateUser(user: User, username: String, bio: String?, completion: (wasSuccesful: Bool) -> Void) {
        
    }
    
    // logs the current User out
    static func logUserOut() {
        
    }
    
    // Mock Users Array
    static func mockUsers() -> [User] {
        return []
    }
    
    
    
    
    
    
}