//
//  Comment.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Comment: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kText = "text"
    private let kPostIdentifier = "postIdentifier"
    
    // MARK: - Properties
    
    var username: String
    var text: String?
    var postIdentifier: String
    var identifier: String?
    
    var endpoint: String {
        return "/posts/\(self.postIdentifier)/comments/"
    }
    
    var jsonValue: [String : AnyObject] {
        get {
            
            var json: [String : AnyObject] =
            [
                kUsername : username,
                kPostIdentifier : postIdentifier
            ]
            if let text = text as? AnyObject {
                json.updateValue(text, forKey: kText)
            }
            if let identifier = identifier as? AnyObject {
                json.updateValue(identifier, forKey: "identifier")
            }
            
            return json
        }
    }
    
    init(username: String, postIdentifier: String) {
        self.username = username
        self.text = nil
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String, let postIdentifier = json[kPostIdentifier] as? String else { return nil }
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
        self.text = json[kText] as? String
    }
    
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}