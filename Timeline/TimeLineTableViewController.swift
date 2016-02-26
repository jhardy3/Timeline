//
//  TimeLineTableViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = UserController.sharedInstance.currentUserVar {
            loadTimeLineForUser(user)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if UserController.sharedInstance.currentUserVar == nil {
            self.tabBarController?.performSegueWithIdentifier("modalSignUpOrIn", sender: nil)
        } else {
            PostController.fetchTimeLineForUser(UserController.sharedInstance.currentUserVar!, completion: { (posts) -> Void in
                self.posts = posts
                self.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timelineCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = self.posts[indexPath.row]
        
        cell.delegate = self
        cell.updateWithPost(post)

        return cell
    }
    
    // MARK: - Updating View Functions
    
    @IBAction func userRefeshedTable(sender: UIRefreshControl) {
        guard let user = UserController.sharedInstance.currentUserVar else { return }
        loadTimeLineForUser(user)
        sender.endRefreshing()
    }
    
    
    func loadTimeLineForUser(user: User) {
        PostController.fetchTimeLineForUser(user) { (posts) -> Void in
            self.posts = posts
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                
            })
        }
    }

}
