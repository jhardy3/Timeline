//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Jake Hardy on 2/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var delegate: TimeLineTableViewController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateWithPost(post: Post) {
        guard let identifier = post.identifier else {
            
            likesLabel.text = String(post.likes.count)
            commentsLabel.text = String(post.comments.count)
            usernameLabel.text = post.username
            return
        }
        
        ImageController.imageForIdentifier(identifier) { (image) -> Void in
            
            self.postImageView.image = image
            self.likesLabel.text = String(post.likes.count)
            self.commentsLabel.text = String(post.comments.count)
            self.usernameLabel.text = post.username
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                guard let delegate = self.delegate else { return }
                delegate.loadView()
                
            })
            
        }
        
    }
    
}
