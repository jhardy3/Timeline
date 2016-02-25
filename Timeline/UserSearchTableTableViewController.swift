//
//  UserSearchTableTableViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableTableViewController: UITableViewController {
    
    var searchController: UISearchController!
    
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
        
        createSearchBar()
        updateViewBasedOnMode()
        
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
        return usersDataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        let user = usersDataSource[indexPath.row]
        cell.textLabel?.text = user.username
        
        // Configure the cell...
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toProfileFromSearchResults" {
            guard let profileView = segue.destinationViewController as? ProfileViewController else { return }
            let cell = sender as! UITableViewCell
            var selectedUser: User
            
            if let indexPath = (searchController.searchResultsController as! UserSearchResultsTableViewController).tableView.indexPathForCell(cell) {
                
                let filteredEntries = (searchController.searchResultsController as! UserSearchResultsTableViewController).usersResultDataSource
                selectedUser = filteredEntries[indexPath.row]
                
            } else {
                let users = usersDataSource
                guard let usersIndexPath = tableView.indexPathForCell(cell) else { return }
                selectedUser = users[usersIndexPath.row]
            }
            
            profileView.user = selectedUser
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

extension UserSearchTableTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text?.lowercaseString else { return }
        let filteredArray = usersDataSource.filter { $0.username.lowercaseString.containsString(searchTerm) }
        guard let resultsController = searchController.searchResultsController as? UserSearchResultsTableViewController else { return }
        resultsController.usersResultDataSource = filteredArray
        resultsController.tableView.reloadData()
        
    }
    
    func createSearchBar() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchResultsIdentifier")
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = "Enter Username"
        searchController.searchResultsUpdater = self
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = true
        
        
        definesPresentationContext = true
        
    }
    
}


