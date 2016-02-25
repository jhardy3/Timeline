//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Jake Hardy on 2/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithImageIdentifier(identifier: String) {
        guard let imageIdentifier = UserController.sharedInstance.currentUserVar?.identifier else { return }
        ImageController.imageForIdentifier(imageIdentifier) { (image) -> Void in
            self.imageView.image = image
        }
    }
    
}
