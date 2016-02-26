//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User?
    var userPosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user == nil {
            self.user = UserController.sharedInstance.currentUserVar
            editButton.enabled = true
        }
        updateBasedOnUser()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateBasedOnUser() {
        guard let user = user else { return }
        PostController.postsForUser(user) { (posts) -> Void in
            guard let posts = posts else { return }
            self.userPosts = posts
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEditProfile" {
            guard let user = user, let destinationView = segue.destinationViewController as? LoginSignupViewController else { return }
                destinationView.updateWithUser(user)
                destinationView.viewWillAppear(true)
        } 
    }
}
extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    
    
    // May need to call main queue and reload view
    func userTappedFollowActionButton() {
        if let user = user where user == UserController.sharedInstance.currentUserVar! {
            UserController.logUserOut()
            self.user = nil
            let instance = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("tabBarController")
            presentViewController(instance, animated: false, completion: nil)
                    } else {
            
            guard let user = user else { return }
            UserController.userFollowsUser(UserController.sharedInstance.currentUserVar!, userTwo: user) { (isFollowing) -> Void in
                if isFollowing {
                    UserController.unfollowUser(user, completion: { (wasSuccesful) -> Void in
                        self.user = user
                    })
                } else {
                    UserController.followUser(user, completion: { (wasSuccesful) -> Void in
                        self.user = user
                    })
                }
            }
        }
    }
    
    func userTappedURLButton() {
        guard let url = user?.url, let cookedURL = NSURL(string: url) else { return }
        let svc = SFSafariViewController(URL: cookedURL)
        
        self.presentViewController(svc, animated: true, completion: nil)
        
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("postCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        if let post = userPosts[indexPath.row].identifier {
            cell.updateWithImageIdentifier(post)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let profileHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "profileHeadCell", forIndexPath: indexPath) as? ProfileHeaderCollectionReusableView
        guard let user = user else { return profileHeaderView!}
        profileHeaderView?.updateWithUser(user)
        profileHeaderView?.delegate = self
        return profileHeaderView!
    }
}
