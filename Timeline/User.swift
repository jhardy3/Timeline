//
//  User.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct User: Equatable {
    
    // MARK: - Properties
    
    var username: String
    var bio: String? = nil
    var url: String? = nil
    var identifier: String?
    
    
    // MARK - Initialization
    
    init(username: String, identifier: String?, bio: String?, url: String?) {
        self.username = username
        self.bio = nil
        self.url = nil
        self.identifier = identifier
    }
    
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}