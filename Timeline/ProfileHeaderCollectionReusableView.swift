//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Jake Hardy on 2/24/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bioButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: ProfileViewController?
    
    func updateWithUser(user: User) {
        
        if user.bio == nil {
            bioButton.hidden = true
        }
        if user.url == nil {
            homePageButton.hidden = true
        }
        
        guard let currentUser = UserController.sharedInstance.currentUserVar where currentUser != user else { followButton.setTitle("Logout", forState: .Normal) ; return }
        UserController.userFollowsUser(currentUser, userTwo: user) { (isFollowing) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if isFollowing {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
        

    }
    
    
    // MARK: - Action Buttons
    
    @IBAction func urlButtonTapped(sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.userTappedURLButton()
    }
    
    @IBAction func followActionButtonTapped(sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.userTappedFollowActionButton()
    }
}



protocol ProfileHeaderCollectionReusableViewDelegate {
    func userTappedFollowActionButton()
    func userTappedURLButton()
    
}