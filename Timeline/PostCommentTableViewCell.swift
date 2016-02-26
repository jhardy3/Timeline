//
//  PostCommentTableViewCell.swift
//  Timeline
//
//  Created by Jake Hardy on 2/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var comment: Comment?
    var delegate: PostDetailTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let comment = comment {
            updateWithComment(comment)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithComment(comment: Comment) {
        userLabel.text = comment.username
        if let text = comment.text {
            commentLabel.text = text
        }
        guard let delegate = delegate else { return }
        delegate.tableView.reloadData()
    }

}
