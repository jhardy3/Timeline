//
//  AddPhotoTableViewController.swift
//  Timeline
//
//  Created by Jake Hardy on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AddPhotoTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    var image: UIImage?
    var caption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
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
        return 2
    }
    
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        if let image = self.image {
            let text = caption ?? ""
            PostController.addPost("-K1l4125TYvKMc7rcp5e", caption: text, completion: { (wasSuccessful, post) -> Void in
                if wasSuccessful {
                self.navigationController?.popViewControllerAnimated(true)
                } else {
                    // Alert
                    self.fireAlert()
                }
            })
        } else {
            // Alert
            self.fireAlert()
        }
    }
    
    @IBAction func addPhotoButtonTapped(sender: UIButton) {
        presentImagePicker()

    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        self.image = image
//    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.image = image
        addPhotoButton.setTitle("", forState: .Normal)
        addPhotoButton.setBackgroundImage(image, forState: .Normal)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentImagePicker() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose a photo", message: "", preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (_) -> Void in
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel:", style: .Cancel, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func fireAlert() {
        let alertController = UIAlertController(title: "Something went wrong, try again", message: "", preferredStyle: .Alert)
        
        let alert = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertController.addAction(alert)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.caption = textField.text
        resignFirstResponder()
    }
}
