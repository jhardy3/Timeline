//
//  Post.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Post: Equatable, FirebaseType {
    
    private let kCaption = "caption"
    private let kUsername = "username"
    private let kImageEndpoint = "imageEndPoint"
    private let kLikes = "likes"
    private let kComments = "comments"
    
    // MARK: - Properties
    
    var imageEndPoint: String
    var caption: String?
    var username: String
    var comments = [Comment]()
    var likes = [Like]()
    var identifier: String?
    
    var endpoint: String {
        return "posts"
    }
    
    var jsonValue: [String : AnyObject] {
        get {
            
            var json: [String : AnyObject] =
            [
                kUsername : username,
                kComments : comments.map { $0.jsonValue } ,
                kLikes : likes.map { $0.jsonValue },
                kImageEndpoint : imageEndPoint
            ]
            if let caption = caption as? AnyObject {
                json.updateValue(caption, forKey: kCaption)
            }
            return json
        }
    }
    
    init(imageEndPoint: String, username: String, caption: String?, comments: [Comment], likes: [Like], identifier: String?) {
        self.imageEndPoint = imageEndPoint
        self.username = username
        self.caption = nil
        self.identifier = nil
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String,
            let imageEndPoint = json[kImageEndpoint] as? String
            else { return nil }
        
        if let comments = json[kComments] as? [[String : AnyObject]] {
            self.comments = comments.flatMap {Comment(json: $0, identifier: identifier) } 
        }
        
        if let likes = json[kLikes] as? [[String : AnyObject]] {
            self.likes = likes.flatMap { Like(json: $0, identifier: identifier) }
        }
        
    
    
    
        self.caption = json[kCaption] as? String
        self.username = username
        self.imageEndPoint = imageEndPoint
    }
    
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}