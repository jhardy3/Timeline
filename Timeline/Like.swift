//
//  Like.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable {
    
    // MARK: - Properties
    
    var username: String
    var postIdentifier: String
    var identifier: String?
    
    init(username: String, postIdentifier: String) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}