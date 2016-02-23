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
    static func uploadImage(image: String, completion: (identifer: String) -> Void) {
        completion(identifer: "-K1l4125TYvKMc7rcp5e")
    }
    
    // returns a UIImage
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        completion(image: UIImage(named: "MockData"))
    }
    
    
    
    
}