//
//  User.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct User: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kBio = "bio"
    private let kURL = "url"
    private let kIdentifier = "identifier"
    private let kEndpoint = "endpoint"
    
    
    // MARK: - Properties
    
    var username: String
    var bio: String? = nil
    var url: String? = nil
    var identifier: String?
    
    
    var endpoint: String {
        return "/user/\(self.identifier)"
    }
    
    var jsonValue: [String : AnyObject] {
        get {
            
            var json: [String : AnyObject] =
            [
                kUsername : username,
            ]
            if let bio = bio as? AnyObject {
                json.updateValue(bio, forKey: kBio)
            }
            if let url = url as? AnyObject {
                json.updateValue(url, forKey: kURL)
            }
            if let identifier = identifier as? AnyObject {
                json.updateValue(identifier, forKey: kIdentifier)
            }
            
            return json
        }
    }
    
    
    // MARK - Initialization
    
    init(username: String, identifier: String?, bio: String?, url: String?) {
        self.username = username
        self.bio = nil
        self.url = nil
        self.identifier = identifier
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String else {
            return nil
        }
        self.username = username
        self.url = json[kURL] as? String
        self.bio = json[kBio] as? String
        self.identifier = identifier
    }
    
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.identifier == rhs.identifier && lhs.username == rhs.username
}