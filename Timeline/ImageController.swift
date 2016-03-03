//
//  ImageController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit


class ImageController {
    
    // MARK: - Properties
    
    
    // MARK: - Static Funcs
    
    // This func uploads an image
    static func uploadImage(image: UIImage, completion: (identifer: String) -> Void) {
        guard let imageConverted = image.base64String else { return }
        let imageBase = FirebaseController.firebase.childByAppendingPath("images").childByAutoId()
        imageBase.setValue(imageConverted)
        completion(identifer: imageBase.key)
        
    }
    
    // returns a UIImage
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        FirebaseController.dataAtEndPoint(identifier) { (data) -> Void in
            if let image = data as? String {
                let completedImage = UIImage(imageAsString: image)
                completion(image: completedImage)
            } else {
                completion(image: nil)
            }
        }
    }
    
    
    
    
}


extension UIImage {
    var base64String: String? {
        get {
            guard let image = UIImageJPEGRepresentation(self, 0.7) else { return nil }
            let imageAsData = image.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
            return imageAsData
        }
    }
    
    
    convenience init?(imageAsString: String) {
        
        guard let data = NSData(base64EncodedString: imageAsString, options: .IgnoreUnknownCharacters) else { return nil }
        self.init(data: data)
        
    }
}