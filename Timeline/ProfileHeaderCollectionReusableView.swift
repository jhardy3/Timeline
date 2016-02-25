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
        UserController.userFollowsUser(UserController.sharedInstance.currentUserVar!, userTwo: user) { (isFollowing) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.followButton.setTitle("Unfollow", forState: .Normal)
            })
        }
        
        if user.bio == nil {
            bioButton.hidden = true
        }
        if user.url == nil {
            homePageButton.hidden = true
        }
        if user == UserController.sharedInstance.currentUserVar {
            followButton.hidden = true
        }
    }
    
    
    // MARK: - Action Buttons
    
    @IBAction func urlButtonTapped(sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.userTappedURLButton()
        delegate.loadView()
    }
    
    @IBAction func followActionButtonTapped(sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.userTappedFollowActionButton()
        delegate.loadView()
    }
}



protocol ProfileHeaderCollectionReusableViewDelegate {
    func userTappedFollowActionButton()
    func userTappedURLButton()
    
}