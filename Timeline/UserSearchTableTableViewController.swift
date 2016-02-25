//
//  UserSearchTableTableViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableTableViewController: UITableViewController {
    
    
    var mode: ViewMode {
        get {
            switch modeSegmentedControl.selectedSegmentIndex.hashValue {
            case 0:
                return .Friends
            case 1:
                return .All
            default:
                return .All
            }
        }
    }
    
    enum ViewMode: Int {
        case Friends = 0
        case All = 1
        
        func users(completion: (users: [User]) -> Void) {
            switch self {
            case .Friends:
                UserController.followedByUser(UserController.sharedInstance.currentUserVar!, completion: { (users) -> Void in
                    guard let users = users else { return }
                    completion(users: users)
                })
            case .All:
                UserController.fetchAllUsers({ (users) -> Void in
                    completion(users: users)
                })
            }
        }
    }
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    var usersDataSource: [User] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewBasedOnMode()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Action Button Functions
    
    @IBAction func selectIndexChanged(sender: UISegmentedControl) {
        updateViewBasedOnMode()
    }
    
    func updateViewBasedOnMode() {
        self.mode.users { (users) -> Void in
            self.usersDataSource = users
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }

}
