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
        UserController.followedByUser(user) { (followed) in
            
            var allPosts: [Post] = []
            let dispatchGroup = dispatch_group_create()
            
            dispatch_group_enter(dispatchGroup)
            postsForUser(UserController.sharedInstance.currentUserVar!, completion: { (posts) -> Void in
                
                if let posts = posts {
                    allPosts += posts
                }
                
                dispatch_group_leave(dispatchGroup)
            })
            
            if let followed = followed {
                for user in followed {
                    
                    dispatch_group_enter(dispatchGroup)
                    postsForUser(user, completion: { (posts) in
                        if let posts = posts {
                            allPosts += posts
                        }
                        dispatch_group_leave(dispatchGroup)
                    })
                }
            }
            
            dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), { () -> Void in
                let orderedPosts = orderPosts(allPosts)
                completion(posts: orderedPosts)
            })
        }
    }
    
    // Adds an image and a post
    static func addPost(image: UIImage, caption: String?, completion: (wasSuccessful: Bool, post: Post?) -> Void) {
        ImageController.uploadImage(image) { (identifer) -> Void in
            guard let user = UserController.sharedInstance.currentUserVar else { completion(wasSuccessful: false, post: nil) ; return }
            var post = Post(imageEndPoint: identifer, username: user.username , caption: caption, comments: [], likes: [], identifier: nil)
            post.save()
            completion(wasSuccessful: true, post: post)
        }
    }
    
    // Get's a post when given a valid identifier
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        FirebaseController.dataAtEndPoint("posts/\(identifier)") { (data) -> Void in
            guard let data = data as? [String : AnyObject] else { completion(post: nil) ; return }
            let post = Post(json: data, identifier: identifier)
            completion(post: post)
        }
        
    }
    
    // Grabs all posts of a particular User
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        FirebaseController.firebase.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { (snap) -> Void in
            guard let posts = snap.value as? [String : AnyObject] else { completion(posts: nil) ; return }
            let mappedPosts = posts.flatMap { Post(json: $0.1 as! [String : AnyObject], identifier: $0.0) }
            completion(posts: mappedPosts)
        })
    }
    
    // Deletes a particular post as specified
    static func deletePost(post: Post) {
        post.delete()
    }
    
    
    // Gonna have bugs here
    // Adds a comment to a post as typed out by another User
    static func addCommentWithTextToPost(text: String, var post: Post, completion: (success: Bool, post: Post?) -> Void) {
        guard let user = UserController.sharedInstance.currentUserVar else { completion(success: false, post: nil) ; return }
        if post.identifier != nil {
            post.save()
            guard let identifier = post.identifier else { completion(success: false, post: nil) ; return }
            var comment = Comment(username: user.username, postIdentifier: identifier)
            comment.save()
            completion(success: true, post: post)
        } else {
            var comment = Comment(username: user.username, postIdentifier: post.identifier!)
            comment.save()
            completion(success: true, post: post)
        }
    }
    
    // Deletes a comment as specified by User
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        guard let identifier = comment.identifier else { completion(success: false, post: nil) ; return }
        comment.delete()
        postFromIdentifier(identifier) { (post) -> Void in
            guard var post = post else { completion(success: false, post: nil) ; return }
            post.save()
            completion(success: true, post: post)
        }
    }
    
    // attributes a like object to a post as specified by User
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        guard let user = UserController.sharedInstance.currentUserVar, let identifier = post.identifier else { completion(success: false, post: nil) ; return }
        var like = Like(username: user.username, postIdentifier: identifier)
        like.save()
        postFromIdentifier(identifier) { (post) -> Void in
            guard let post = post else { completion(success: false, post: nil) ; return }
            completion(success: true, post: post)
        }
        
    }
    
    // deletes a like as specified by user
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        guard let identifier = like.identifier else { completion(success: false, post: nil) ; return }
        like.delete()
        postFromIdentifier(identifier) { (post) -> Void in
            guard let post = post else { completion(success: false, post: nil) ; return }
            completion(success: true, post: post)
        }
    }
    
    // returns an array of posts in a specific order
    static func orderPosts(posts: [Post]) -> [Post] {
        return posts.sort {$0.0.identifier > $0.1.identifier }
    }
    
    
    
}