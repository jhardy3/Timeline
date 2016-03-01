//
//  Like.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kPostIdentifier = "postIdentifier"
    
    // MARK: - Properties
    
    var username: String
    var postIdentifier: String
    var identifier: String?
    
    var endpoint: String {
        return "/posts/\(self.identifier)/likes/"
    }
    
    var jsonValue: [String : AnyObject] {
        get {
            
            let json: [String : AnyObject] =
            [
                kUsername : username,
                kPostIdentifier : postIdentifier
            ]
            
            return json
        }
    }
    
    init(username: String, postIdentifier: String) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String, let postIdentifier = json[kPostIdentifier] as? String else { return nil }
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}