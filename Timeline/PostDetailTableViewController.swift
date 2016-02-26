//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post?
    @IBAction func addCommentTapped(sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            updateBasedOnPost(post)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action Button Functions
    
    @IBAction func likeTapped(sender: UIBarButtonItem) {
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        if let comments = post?.comments {
            let comment = comments[indexPath.row]
        }

        return cell
    }
    
    func updateBasedOnPost(post: Post) {
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
            self.headerImageView.image = image
            self.commentsLabel.text = String(post.comments.count)
            self.likesLabel.text = String(post.likes.count)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }

}
