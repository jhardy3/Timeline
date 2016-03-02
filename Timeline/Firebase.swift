//
//  File.swift
//  Timeline
//
//  Created by Jake Hardy on 2/29/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let firebase = Firebase(url: "timeline4ever.firebaseIO.com/")
    
    static func dataAtEndPoint(endpoint : String, completion: (data: AnyObject?) -> Void) {
        let baseAtEndPoint = firebase.childByAppendingPath(endpoint)
        baseAtEndPoint.observeSingleEventOfType(.Value, withBlock: {(snap) -> Void in
            guard let snap = snap.value else { completion(data: nil) ; return }
            completion(data: snap)
        })
    }
    
    static func observeDataAtEndPoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseAtEndPoint = firebase.childByAppendingPath(endpoint)
        baseAtEndPoint.observeEventType(.Value, withBlock: { (snap) -> Void in
            guard let snap = snap.value else { completion(data: nil) ; return }
            completion(data: snap)
        })
    }
    
    
}

protocol FirebaseType {
    
    var identifier: String? { get set }
    var endpoint: String { get }
    var jsonValue: [String : AnyObject] { get }
    
    init?(json: [String : AnyObject], identifier: String)
    
    mutating func save()
    func delete()
}

extension FirebaseType {
    mutating func save() {
        if let identifer = identifier {
            FirebaseController.firebase.childByAppendingPath(identifer).updateChildValues(jsonValue)
        } else {
            let firebaseIdentifier = FirebaseController.firebase.childByAutoId()
            self.identifier = firebaseIdentifier.key
            firebaseIdentifier.updateChildValues(jsonValue)
        }
        
    }
    
    func delete() {
        FirebaseController.firebase.removeValue()
    }
}