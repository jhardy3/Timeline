//
//  File.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    // MARK: - Properties
    
    
    // MARK: - Static Func
    
    // Grabs timeline data for a given user
    static func fetchTimeLineForUser(user: User, completion: (posts: [Post]) -> Void) {
        completion(posts: mockPosts())
    }
    
    // Adds an image and a post
    static func addPost(image: String, caption: String?, completion: (wasSuccessful: Bool, post: Post?) -> Void) {
        
    }
    
    // Get's a post when given a valid identifier
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
    }
    
    // Grabs all posts of a particular User
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
    }
    
    // Deletes a particular post as specified
    static func deletePost(post: Post) {
        
    }
    
    // Adds a comment to a post as typed out by another User
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    // Deletes a comment as specified by User
    static func deleteComment(comment: Comment, completiong: (success: Bool, post: Post?) -> Void) {
    }
    
    // attributes a like object to a post as specified by User
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    // deletes a like as specified by user
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    // returns an array of posts in a specific order
    static func orderPosts(posts: [Post]) -> [Post] {
        return []
    }
    
    static func mockPosts() -> [Post] {
        return [
            
            Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", username: "JakeOfUtah", caption: nil, comments: [], likes: [], identifier: nil),
            Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", username: "exMachina", caption: nil, comments: [], likes: [], identifier: nil),
            Post(imageEndPoint: "-K1l4125TYvKMc7rcp5e", username: "xXsupsXx", caption: nil, comments: [], likes: [], identifier: nil)
            
        ]
    }
    
}