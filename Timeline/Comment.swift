//
//  Comment.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Comment: Equatable {
    
    // MARK: - Properties
    
    var username: String
    var text: String?
    var postIdentifier: String
    var identifier: String?
    
    init(username: String, postIdentifier: String) {
        self.username = username
        self.text = nil
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
    
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}