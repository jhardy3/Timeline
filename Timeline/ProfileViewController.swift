//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User?
    var userPosts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

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

}

extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    
    
    // May need to call main queue and reload view
    func userTappedFollowActionButton() {
        guard let user = user else { return }
        UserController.userFollowsUser(UserController.sharedInstance.currentUserVar!, userTwo: user) { (isFollowing) -> Void in
            if isFollowing {
                UserController.unfollowUser(user, completion: { (wasSuccesful) -> Void in
                    
                })
            } else {
                UserController.followUser(user, completion: { (wasSuccesful) -> Void in
                    
                })
            }
        }
    }
    
    func userTappedURLButton() {
        
        
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("postCell", forIndexPath: indexPath)
        return cell
    }
}