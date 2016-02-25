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
    
    var currentUserVar: User? = User(username: "Test", identifier: nil, bio: nil, url: nil)
    
    static let sharedInstance = UserController()
    
    // MARK: - Static Functions
    
    // Returns a User in a completion block based on a query with passed in identifier
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
            completion(user: mockUsers().first)
    }
    
    // Returns all users in a completion block
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        completion(users: mockUsers())
        
    }
    
    // Function allows a User to Follow another User
    static func followUser(user: User, completion: (wasSuccesful: Bool) -> Void) {
        completion(wasSuccesful: true)
    }
    
    // Alternatively unfollows a user
    static func unfollowUser(user: User, completion: (wasSuccesful: Bool) -> Void) {
        completion(wasSuccesful: true)
    }
    
    // Checks to see if a user is following another user
    static func userFollowsUser(userOne: User, userTwo: User, completion: (isFollowing: Bool) -> Void) {
        completion(isFollowing: true)
    }
    
    // Shows wh0 is is following a user
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        completion(users: [User(username: "ACREEPER", identifier: nil, bio: nil, url: nil)])
    }
    
    // Check to see if a user is actually relevant when loggin in
    static func authenticateUser(email: String, password: String, completion: (wasSuccesful: Bool, user: User?) -> Void) {
        completion(wasSuccesful: true, user: mockUsers().first)
    }
    
    // Creates a new user if valid information inputed
    static func createUser(email: String, password: String, bio: String?, url: String?, completion: (wasSuccesful: Bool, user: User?) -> Void) {
        completion(wasSuccesful: true, user: mockUsers().first)
    }
    
    // Updates the current User
    static func updateUser(user: User, username: String, bio: String?, completion: (wasSuccesful: Bool) -> Void) {
        completion(wasSuccesful: true)
    }
    
    // Just a test
    static func currentUserTest() -> User? {
        return nil
    }
    
    // logs the current User out
    static func logUserOut() {
        
    }
    
    // Mock Users Array
    static func mockUsers() -> [User] {
        return [
        
            User(username: "JakeOfUtah", identifier: nil, bio: nil, url: nil),
            User(username: "nilCoalescer", identifier: nil, bio: nil, url: nil),
            User(username: "xXsupsXx", identifier: nil, bio: nil, url: nil)
            
        ]
    }
    
    
    
    
    
    
}