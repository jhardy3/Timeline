//
//  Post.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Post: Equatable {
    
    // MARK: - Properties
    
    var imageEndPoint: String
    var caption: String?
    var username: String
    var comments = [Comment]()
    var likes = [Like]()
    var identifier: String?
    
    init(imageEndPoint: String, username: String, caption: String?, comments: [Comment], likes: [Like], identifier: String?) {
        self.imageEndPoint = imageEndPoint
        self.username = username
        self.caption = nil
        self.identifier = nil
    }
    
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}