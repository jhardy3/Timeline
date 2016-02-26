//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post?
    
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
    
    @IBAction func addCommentTapped(sender: UIButton) {
        let alertController = UIAlertController(title: "So, you wanna add a comment?", message: "", preferredStyle: .Alert)
        
        let addComment = UIAlertAction(title: "Add Comment", style: .Default) { _ in
            guard let post = self.post else { return }
            if let textfields = alertController.textFields {
                if textfields[0].hasText() {
                    if let text = textfields[0].text {
                        PostController.addCommentWithTextToPost(text, post: post, completion: { (success, post) -> Void in
                            if success {
                                guard let post = post else { return }
                                self.post = post
                            }
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.tableView.reloadData()
                            })
                        })
                    }
                }
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Enter Comment"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(addComment)
        alertController.addAction(cancel)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! PostCommentTableViewCell
        if let comments = post?.comments {
            let comment = comments[indexPath.row]
            cell.updateWithComment(comment)
            cell.delegate = self
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
