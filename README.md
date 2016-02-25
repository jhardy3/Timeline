# Timeline

### Level 3

Timeline is a simple photo sharing service. Students will bring in many concepts that they have learned, and add complex data modeling, Image Picker, Collection Views, NSURLSession, Firebase, and protocol-oriented programming, 

This is a Capstone Level project spanning many class days and concepts. Most concepts will be covered during class, others are introduced during the project. Not every instruction will outline each line of code to write, but lead the student to the solution.

Students who complete this project independently are able to:

#### Part One - Project Planning, Model Objects, and Controllers

* follow a project planning framework to build a development plan
* follow a project planning framework to prioritize and manage project progress
* implement a layered tab bar based view hierarchy
* implement a related data model architecture
* add staged data to a model object controller

#### Part Two - Wire Up Views

* use an enum to create a customizable table view
* build a reusable log in/sign-up view controller
* implement a collection view based master-detail interface
* implement a search controller

#### Part Three - Wire Up Views (contd)

* implement a complex UITableView with multiple cell types and sections
* implement multiple custom table view cells with delegate pattern
* use an image picker to access and work with photos
* use an accessory editing view as a text field and send button

#### Part Four - Implement Controllers

* use Firebase as a backend for storing and pulling related model objects
* implement the Firebase controller and model object controllers to work with live data
* implement a custom protocol for Firebase model objects, controllers, and live updating views
* use dispatch groups to verify task completion before returning values

#### Part Five - Implement Controllers

* upload photos to Firebase as base64 strings
* asynchronously download photos to display
* authenticate users via e-mail

Follow the development plan included with the project to build out the basic view hierarchy, basic implementation of local model objects and model object controllers, and build staged data to lay a strong foundation for the rest of the project.

### View Hierarchy


    
### Implement Model

#### User

#### Comment

#### Like

Create a 'Like' model struct that will hold a username, and reference to the parent ```Post```.

#### Post

### Model Controller API

### UserController

### PostController

### ImageController

### Black Diamonds

### Tests

## Part Two - Wire Up Views

##### Storyboard Setup

We will implement the code for this view after setting up the Signup / Login View scene.

### Signup / Login View

Build a view to manage signup and login features for the application. The view will have two modes: Signup and Login. When in Signup mode, we will display all fields required to sign up a new user. When in Login mode, we will programmatically remove unnecessary fields. 


##### Class Implementation

##### Present the View if No Current User

Build a check on the ```UserController.currentUser()``` to present the Login / Signup Picker scene if there is no user logged in.

##### Setting the Mode from the Choice Scene

3. Test your different modes to verify they work as expected, that the view is presented, and that the view is dismissed when the user successfully logs in or registers.

### User Search Table View

##### Search Controller Implementation


















##### Segue to the Profile View


### Profile View



##### Collection View Section Header

##### View Hierarchy Details



3. Update the ```viewDidLoad``` function to check ```self.user``` for nil, if it is, assign the current user to the value.

##### Enable Profile Editing for Current User

Build functionality for the user to update their profile using the Login/Signup View we built earlier.

Update the Login / Signup View to support updating a ```User```.


Update the Profile View Controller to support Editing


Consider how you could modify these steps to be more efficient in relying on network requests.

##### Logging Out

Add functionality for the current user to log out.

1. In the ```ProfileHeaderCollectionReusableView```, use the follow button as a logout button if the user is equal to the currentUser. Set the title appropriately.
2. In the implementation of the ```userTappedFollowActionButton()``` delegate method, check if the user is equal to the currentUser. If so, log out the current user and send the user to the first view controller in the tab bar. If not, it should do the appropriate follow/unfollow action.








































## Part Three - Wire Up Views (contd)

* implement a complex UITableView with multiple cell types and sections
* implement multiple custom table view cells with delegate pattern
* use an image picker to access and work with photos
* use an accessory editing view as a text field and send button

### Timeline View

The Timeline view is the most important view of the application. This is where people will see and like the photos. Each cell will represent one post and will display the photo, user, number of comments, and number of likes. Be creative but follow sound design principles in how you display each post in the cell.

##### Custom Post Cell

1. Design the cell in ```Main.storyboard``` to display the image prominently, include labels for the number of likes and number of comments.
    * note: Consider displaying the photo as the full background of the cell, use a Stack View to place the labels.
    * note: Consider the Content Mode and choose one that will work for most images, you can address this later in the polish portion.
2. Add a ```PostTableViewCell.swift``` subclass of ```UITableViewCell``` and assign it as the class for the cell on our Timeline scene.
3. Add outlets for the ```postImageView```, ```likesLabel``` and ```commentsLabel```.
4. Add a ```updateWithPost(post: Post)``` function.
5. Implement the function by assigning values to the labels and using the ImageController to fetch the image, assign the result to the image view in the completion closure.

##### Timeline DataSource

1. Open the ```TimelineTableViewController.swift``` subclass of ```UITableViewController``` and check that it is assigned to the associated scene in ```Main.storyboard``` 
2. Add a variable ```posts``` that will hold the posts for the Timeline.
3. Add a function ```loadTimelineForUser``` that takes a ```User``` as a parameter.
4. Implement the function by using the ```PostController``` to fetch timeline for the user, setting the results to ```self.posts```, and reloading the view when completed.
5. Update the ```viewDidLoad()``` function to call ```loadTimelineForUser``` if there is a current user.
    * note: Keep the previously written code, we still need to present the Login view if there is no current user.
6. Implement the ```numberOfRowsInSection``` by returning the count of posts.
7. Implement the ```cellForRowAtIndexPath``` by dequeing a ```PostTableViewCell```, capturing the ```Post```, and calling the ```updateWithPost(post: Post)``` function on the cell.

##### Pull to Refresh

Implement 'Pull to Refresh' functionality on your ```TimelineTableViewController```

1. Select the scene in the Document Outline in ```Main.storyboard```.
2. Enable refreshing in the Attributes Inspector under Table View Controller.
3. Add an IBAction ```userRefreshedTable``` for the Refresh Control now visible in your Document Outline.
4. Implement the action by fetching an updated timeline from the ```PostController```.
    * note: You must tell the refresh control to ```endRefreshing``` when the view is done loading.

### Post Detail View

Build a Post Detail View that displays the post. It should display the photo and the comments. The view should also allow the user to post comments or add likes to the post. 

1. Open the ```PostDetailTableViewController.swift``` subclass of ```UITableViewController``` and check that it is assigned to the associated scene in ```Main.storyboard```. 
2. Add a Header view to the ```UITableView``` with a similar layout to the ```PostTableViewCell```.
    * note: Some photos may expand beyond this header view, choose the 'Clip Subviews' option in the Attribute Inspector.
3. Add a subtitle prototype cell with a Username label and Comment label that will display the details of each comment.
4. Add a button as a footer view titled 'Add Comment'.
5. Add a ```UINavigationItem``` with a Bar Button Item titled 'Like'.
6. Add IBOutlets for the ```headerImageView```, ```likesLabel```, and ```commentsLabel```.
7. Add a property of ```Post?``` to the view controller.
8. Add a function ```updateBasedOnPost()```.
9. Implement the function by updating the ```likesLabel```, ```commentsLabel```, using the ```ImageController``` to set the ```headerImageView``` and reloading the table view.
10. Call ```updateBasedOnPost()``` in ```viewDidLoad()```.
11. Add an IBAction ```likeTapped``` from the 'Like' button.
12. Implement the ```likeTapped``` function by using the ```PostController``` to add a ```Like``` to the post, update the view with the updated post in the completion closure.
13. Add an IBAction ```addCommentTapped``` from the 'Add Comment' button.
14. Implement the ```addCommentTapped``` function to present a ```UIAlertController``` with a textfield, an 'Add Comment' action, and a 'Cancel' action.
15. Implement the 'Add Comment' action to use the ```PostController``` to add a comment, update the view with the updated post in the completion closure.
16. Implement the ```numberOfRowsInSection``` by returning the count of comments on ```self.post```.
17. Implement the ```cellForRowAtIndexPath``` by dequeing a ```PostCommentTableViewCell```, capturing the ```Comment```, and calling the ```updateWithComment(comment: Comment)``` function on the cell.

##### Segues to Post Detail View

1. Add a ```prepareForSegue``` function to the ```TimelineTableViewController.swift``` file
2. Implement the function by capturing the ```indexPath```, selected ```Post```, ```destinationViewController```, and updating the ```destinationViewController``` with the selected post.
3. Add a ```prepareForSegue``` function to the ```ProfileViewController.swift``` file.
4. Implement he function by capturing the ```indexPath```, selected ```Post```, ```destinationViewController```, and updating the ```destinationViewController``` with the selected post.

### Add Post View

Build a view for creating and submitting a post. The view should have a way to select a photo using the ```UIImagePickerController```, adding a caption, and submitting. You will use a static table view with a header and footer to create this form. This is not the only way to build this view, but is an appropriate use for a static ```UITableView```.

You will use a button as the header view to allow the user to select a photo. When the user has chosen a photo, display it using the button's background image property and set the title to an empty string.

You will use a static cell with a text field for capturing the caption for the post, and a 'Submit' button as the footer for the table view.

1. Update the table view to use static cells.
2. Add a button as the header for the table view titled 'Add Photo'.
    * note: Update the title and font size, make the view larger so that the user can see the photo.
3. Remove any additional table view cells, add a text field that fills the cell, provide context to the user with placeholder text.
4. Add a 'Submit' button as the footer to the table view.
5. Add a 'Cancel' button as the left bar button item.
6. Add IBOutlets for the 'Add Photo' button and caption text field.

##### Add Photo

Add a property for storing the image for the post, present a ```UIImagePickerController```, and update the 'Add Photo' button to display the image.

7. Add an optional ```self.image``` property to capture the selected image for the post.
8. Add an IBAction ```addPhotoButtonTapped``` to the ```AddPhotoTableViewController.swift``` file.
9. Implement the function by instantiating a ```UIImagePickerController```, setting it's delegate, presenting an alert to the user to choose 'Photo Library' or 'Camera', setting the ```sourceType``` of the picker controller, and presenting it.
9. Adopt the ```UINavigationControllerDelegate``` and ```UIImagePickerControllerDelegate``` protocols.
10. Implement the ```UIImagePickerControllerDelegate``` function ```didFinishPickingMediaWithInfo``` to dismiss the picker view controller, capture the selected image into the ```self.image``` property, and updating the background image of the photo button.

##### Capture the Caption

Follow the same pattern you used for the ```self.image``` property by capturing the value when the user stops editing the caption text field.

11. Add an optional ```caption``` property to capture the text when the user finishes updating the cell.
12. Adopt the ```UITextFieldDelegate``` protocol, set the delegate of the text field, and implement the ```textFieldShouldReturn``` function to set the ```caption``` property and ```resignFirstResponder```.

##### Submitting the Post

13. Add an IBAction ```submitButtonTapped``` from the 'Submit' button.
14. Implement the function by checking for a value in ```self.image```, if there is an image, use the ```PostController``` to add a post with the image and caption, if there isn't an image, present an alert to the user asking them to check and try again.
15. Handle the ```PostController``` unsuccessfully uploading the image by presenting an alert to the user asking them to try again.

##### Cancel Button

16. Add an IBAction ```cancelButtonTapped``` from the 'Cancel' button.
17. Implement the function by dismissing the view controller.


### Black Diamonds

* fix the content mode of the 'Add Photo' button to use .ScaleAspectFill
* add 'double tap to like' functionality to the cell
* make the post view a live view by observing the post

### Tests


## Part Four - Implement Controllers

* use Firebase as a backend for storing and pulling model objects
* implement the Firebase controller and model object controllers to work with live data
* implement a custom protocol for Firebase model objects, controllers, and live updating views

It is time to implement actual funtionality for our controller objects. You will import the Firebase library into the application, create a reusable ```FirebaseController``` helper class that will perform basic Firebase interactions for authentication and fetching and pushing data, and get the model objects ready to save to Firebase by writing and implementing a ```FirebaseType``` protocol.

### Add Firebase to the Project

Install the Firebase iOS SDK by manually including the ```Firebase.framework``` and its dependencies in the project.

1. Open the [iOS Alternative Setup](https://www.firebase.com/docs/ios/alternate-setup.html) documentation.
2. Follow the steps to download the framework and add dependencies to the project.
    * note: As of Xcode 7.1, .dylib is now .tbd when referencing dependencies and linked frameworks.
3. Create a new App in Firebase with a unique subdomain of your choice to use for the project.

### FirebaseController

Create a reusable ```FirebaseController``` class that will provide basic fetching features. If written correctly, the only reference to your current project will be the ```base``` property that references the URL on Firebase for your application. Everything else will be migratable and reusable in other projects you build. Add to your ```FirebaseController``` over time with the most reused features.

1. Create a new ```FirebaseController.swift``` class and define a new ```FirebaseController``` class.
2. Import Firebase.
3. Add a new class property ```base``` that returns a ```Firebase``` from your URL.
4. Add a static function ```dataAtEndpoint(endpoint: String, completion: (data:AnyObject?) -> Void)``` that will fetch data from an endpoint and return it via completion closure.
5. Implement the function to create a new Firebase reference with the endpoint string, observe a single event, and run the completion closure when the data has returned.
    * note: Check to see if the data is NSNull before running the completion. This will determine what you pass to the closure's parameter.
6. Add a static ```observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void)``` that will observe data from and endpoint and run the completion closure each time the data at that endpoint changes.
7. Implement the function to create a new Firebase reference with the endpoint string, observe an event, and run the completion closure when the data has returned.
    * note: Check to see if the data is NSNull before running the completion.

Note that these functions are not necessary, but will save you two lines of code each time you want to fetch or observe data in Firebase. You can build your ```FirebaseController``` over time to be more useful to you as you recognize patterns of what you do repeatedly in Firebase that can be abstracted to this helper class.

##### Define the Protocol

The ```FirebaseController.swift``` file is the perfect place to add more Firebase specific code that will help you write the rest of the application. Write a ```FirebaseType``` protocol that will normalize and enforce the way model objects are built to save and pull from Firebase. Before writing the protocol, consider everything that you would require a model object to have to work seamlessly with Firebase.

There are 4 or 5 required properties or functions, depending on your specific implementation, that you will want to include:

* ```identifier```
* ```endpoint```
* ```secondaryEndpoints``` (depends on implementation and architecture)
* ```jsonValue```
* ```init?(json: [String: AnyObject])``` (because of the way we've structured our data in this specific app, we will use ```init?(json: [String: AnyObject], identifier: String)```)

With these 5 required properties/functions, we can implement a couple of great features with default protocol implementations. You will implement two:

* ```save()```
* ```delete()```

1. Add a protocol definition for ```FirebaseType``` at the bottom of the ```FirebaseController.swift``` file.
2. Add an optional gettable and settable ```identifier:[String]?``` property.
    * note: The identifier will be used to identify the object on Firebase, and when nil, tells us that the object has not yet been saved to Firebase.
3. Add a gettable ```endpoint: String``` property.
    * note: The endpoint will determine where the object will be saved on Firebase.
4. Add a gettable ```jsonValue: [String, AnyObject]``` property.
    * note: A JSON representation of the object that will be saved to Firebase.
5. Add a faillable ```init?(json: [String: AnyObject] identifier: String)``` function.
    * note: Any instance initialized with json will come from Firebase, and will require an identifier so we know it already exists on Firebase.
6. Add a ```mutating func save()``` function.
7. Add a ```func delete()``` function .

##### Extend the Protocol

Using protocol extensions in Swift, we can require functions and provide default implementations for those functions for any type that conforms to the protocol.

1. Define an extension to FirebaseType at the bottom of the ```FirebaseController.swift``` file.
2. Add a mutating ```save()``` function.
3. Implement the function by checking for an identifier, if there is an identifier, instantiate a Firebase reference to the endpoint with that identifier, otherwise instantiate a Firebase reference to the endpoint with a ```.childByAutoID()```, and assign the identifier to the key of that base, once you have a reference to where the object should be saved, use the ```updateChildValues()``` function with the ```jsonValue``` of the object.
4. Add a ```delete()``` function.
5. Implement the function by instantiating a Firebase reference to the object, use the ```removeValue()``` function to delete it from Firebase.


### Adopt the FirebaseType Protocol

Adopt the ```FirebaseType``` protocol in each of your model objects. Use the included sample JSON to build your ```jsonValue``` calculated properties and ```init?(json: [String: AnyObject], identifier: String)``` initializers.

##### Comment

Example:

```
"-K28xPOXBBXdCrFx-EAY" : {
    "post" : "-K25Fj8qrMAtxXG3QCSn",
    "text" : "I'd love to cliff dive off that.",
    "username" : "calebhicks"
}
```

1. Add private String keys for "post", "username", and "text".
2. Assign a value for a computed ```endpoint``` property. Look at the example:

```
var endpoint: String {
    
    return "/posts/\(self.postIdentifier)/comments/"
}
```

Saving the ```jsonValue``` to this endpoint will put it under the post that it belongs to on Firebase.

3. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```postIdentifier```, ```user```, and ```text```.
4. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.

##### Like

Example:

```
"-K28OeV3MmD0l9DbNufW" : {
    "post" : "-K25Fj8qrMAtxXG3QCSn",
    "username" : "calebhicks"
}
```
.
1. Add private String keys for "post" and "username".
2. Assign a value for a computed ```endpoint``` property that saves the ```Like``` to the post, similar to the ```endpoint``` for ```Comment```.
3. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```postIdentifier``` and ```username```.
4. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.


##### Post

Example: 

```
"-K25Fj8qrMAtxXG3QCSn" : {
  "username" : "hansolo",
  "imageEndpoint" : "-K25Fj8p2ArUMz3awt3T",
  "comments" : {
    "-K28xPOXBBXdCrFx-EAY" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "text" : "I'd love to cliff dive off that.",
      "username" : "calebhicks"
    },
    "-K28xzlhs8ArmgB6bcCB" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "text" : "Who wants in?",
      "username" : "calebhicks"
    }
  },
  "likes" : {
    "-K28OeV3MmD0l9DbNufW" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "username" : "calebhicks"
    },
    "-K28xx1BC5pnQNXDxym6" : {
      "post" : "-K25Fj8qrMAtxXG3QCSn",
      "username" : "calebhicks"
    }
  }
}
```

1. Add private String keys for "username", "imageEndpoint", "caption", "comments", and "likes".
2. Conform to the ```FirebaseType``` protocol.
3. Assign a value 'posts' for ```endpoint```.
    * note: ```Post``` objects are not saved under any other object, so it has it's own independent endpoint.
4. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```username```, ```imageEndpoint```, ```comments```, ```likes```, and optionally add the ```caption``` if it exists.
    * note: Map the Comments and Likes to dictionaries (ex. ```CommentsKey: self.comments.map({$0.jsonValue})```).
5. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.
    * note: Map the Comment and Like dictionaries to initialized model objects, use flatMap() to filter out any nil optional initialized objects.
    * note: Consider the included sample solution below, break each line down, look in the documentation to understand what each part is doing.

```
if let commentDictionaries = json[CommentsKey] as? [String: AnyObject] {
    self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
} else {
    self.comments = []
}
```

##### User

Example:

```
"17c014cb-5cc1-4884-977b-471482d9e484" : {
    "bio" : "I wear fancy pants. ",
    "follows" : {
        "c6c2fbe1-c86c-4b47-a78b-5d991c8f19fb" : true,
        "f8270303-6656-453a-a2e6-8c5eeece73b7" : true
    },
    "url" : "http://calebhicks.com/",
    "user" : "calebhicks"
}
```

1. Add private String keys for "username", "bio", and "url".
2. Assign a value 'users' for ```endpoint```.
3. Implement the ```jsonValue``` calculated property by returning a json dictionary with the ```username```, optionally include the ```bio``` and ```url```, if they exist.
4. Implement the failable initializer by guarding against the required properties, setting any optional properties, and assigning the identifier.


### PostController Implementation

The ```PostController``` is a crucial piece to the application. Do your best to write the implementation for each function with only the description here. Sample solution code is available, but should only be used after trying your best to implement each function. Each function takes parameters and returns others, do your best to translate the inputs into the outputs. 

1. Implement the ```addPost``` function to use the ```ImageController``` to upload an image, use the closure identifier to initialize a post, save it, and call the completion closure.
2. Implement the ```postFromIdentifer``` function to use the ```FirebaseController``` to fetch data for the post (ex. ```"posts/\(identifier)"```), unwrap the data, initialize the post, and call the completion closure.
3. Implement the ```postsForUser``` function to create a ```Firebase``` reference query to all posts where "username" is equal to the username passed into the function, unwrap the optional data, flatMap the dictionaries into ```Post``` objects, order the posts, and call the completion closure.
    * note: Watch out for the auto closure completion Xcode creates for Firebase observe functions, it oftentimes will choose a different syntax than works.
    * note: The master dictionary will contain child dictionaries that map to Posts. Use tuple accessors to correctly grab the identifier and child dictionary to map, ask for help if you do not understand the syntax.
4. Implement the ```deletePost``` function by deleting the post.
5. Implement the ```addCommentWithTextToPost``` to check for a postIdentifier (if none, save the post, thereby getting a postIdentifier), initialize a ```Comment```, save the comment, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
6. Implement the ```deleteComment``` function to delete the comment, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
7. Implement the ```addLikeToPost``` to check for a postIdentifier, initialize a ```Like```, save the like, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
8. Implement the ```deleteLike``` function to delete the like, fetch the updated post using the identifier, and calling the completion closure with the newly fetched ```Post```.
9. Implement the ```orderPosts``` function to return a sorted array using the identifier of the ```Post``` object.
    * note: Firebase creates the unique identifiers by using a timestamp, so sorting by the identifier sorts by timestamp.
    * note: This function is particularly useful in the ```fetchTimeline``` function that appends ```Post``` objects from different users, this function sorts them back into order by time.

* note: You should not expect to see a great difference in your app functionallity today.

## Part Five - Implement Controllers

* upload photos to Firebase as base64 strings
* asynchronously download photos to display
* authenticate users anonymously or via e-mail

### PostController

The ```PostController``` has one more function we need to implement, ```fetchTimelineForUser```.  First, you will need to get all of the user the current user is following. Second, for each of those users, you'll need to fetch their posts. Third, you should fetch all of the current users posts. (If the user uploads an image, they should see it on their own timeline.) Use [dispatch groups](http://commandshift.co.uk/blog/2014/03/19/using-dispatch-groups-to-wait-for-multiple-web-services/) to be notfied when all of your asyncronous calls are complete.

1. Implement the ```fetchTimelineForUser()``` by first calling ```followedByUser```. In the completion closure, create an array the will hold all the posts and a dispatch group.
2. Enter the dispatch group. Call ```postForUser``` to fetch the current users posts. Once the post have been fetched leave the dispatch group.
3. For each user that is being followed, enter the dispatch group, fetch their posts, then once the posts have been returned, leave the dispatch group.
4. When the dispatch group notifies it has completed, order the posts and call the completion closure. 

### UserController Implementation

The ```UserController``` is a crucial piece to the application. Do your best to write the implementation for each function with only the description here. Sample solution code is available, but should only be used after trying your best to implement each function. Each function takes parameters and returns others, do your best to translate the inputs into the outputs. 

1. Add a private ```kUser``` for use with ```NSUserDefaults``` and the ```currentUser``` calculated property.
2. Implement the ```currentUser``` computed property to use a ```get``` and ```set``` to push and pull from ```NSUserDefaults```. ```get``` should guard against the ```uid``` on the ```FirebaseController.base.authData``` property and a userDictionary from ```NSUserDefaults```, and return a User created from the results. ```set``` should unwrap the ```newValue```, if it exists, save it to ```NSUserDefaults```, if it does not, remove it from ```NSUserDefaults```.

```
var currentUser: User! {
    get {
        
        guard let uid = FirebaseController.base.authData?.uid,
            let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(UserKey) as? [String: AnyObject] else {
                
                return nil
        }
        
        return User(json: userDictionary, identifier: uid)
    }
    
    set {
        
        if let newValue = newValue {
            NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: UserKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(UserKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}

```

3. Implement the ```userForIdentifier``` function to fetch data at the endpoint for the user, unwrap the data, initialize the ```User```, and call the completion.
4. Implement the ```fetchAllUsers``` function to fetch all data at the "users" endpoint, unwrap the optional data, flatMap the dictionaries into ```User``` objects, and call the completion closure.
5. Implement the ```followUser``` function to create a Firebase reference to the endpoint for followed users ("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)"), set ```true``` to that endpoint, and call the completion closure.
6. Implement the ```unfollowUser``` function to do remove the value at the followed user endpoint.
7. Implement the ```userFollowsUser``` function to check if there is a value at the followed user endpoint and call the appropriate completion closure.
8. Implement the ```followedByUser``` function to fetch identifiers for all followed users, unwrap the optional data, create a holding array for users, loop through the identifiers to call the ```userForIdentifier``` function, append each user, and call a completion closure.
    * note: This implementation may be inefficient and potentially cause issues. Consider how you could better approach this problem. Experiment with potential solutions.
9. Implement the ```authenticateUser``` function to ```authUser``` on the ```FirebaseController.base``` reference, if you successfully authenticate, fetch the user using the identifier, and set the ```currentUser``` property on ```sharedController``` to the result.
    * note: You will need to enable E-mail Authentication on your Firebase Dashboard for this to work.
10. Implement the ```createUser``` function to ```createUser``` on the ```FirebaseController.base``` reference, if you succeed, initialize a ```User``` object using the ```uid``` and other parameters, save the user, then authenticate the user to log the user in.
11. Implement the ```updateUser``` function to initialize a new ```User``` object with the same identifier and new parameters, save the user (which will overwrite the updated values on the server), fetch a new copy of the user using the identifier, set the ```currentUser``` property on ```sharedController```, and call the completion closure.
12. Implement the ```logoutCurrentUser``` function to ```unAuth``` on the ```FirebaseController.base``` reference, set the ```currentUser``` property on the ```sharedController``` to nil.

### ImageController Implementation

In an ideal world, we would host our images to Amazon S3 for fast, cheap asset hosting. However, in the spirit of building a Minimum Viable Product and using the tools we already have, we're going to host images on Firebase. Firebase does not natively support images, but it does support strings. Images can be converted to and from string values using Base64 encoding and decoding. You will build the ```ImageController``` and an extension on ```UIImage``` that provides the encoding and decoding for you.

##### Base 64 Encode / Decode

1. Define a new extension for ```UIImage``` at the bottom of the ```ImageController.swift``` file.
2. Create a calculated property ```base64String``` that returns an optional string.
3. Implement the calculated property by guarding a compressed ```UIImageJPEGRepresentation``` copy of the image represented as ```NSData```.
    * note: Play with various compression rates, the higher the compression, the faster loading images will go.
4. Return the data as a string with ```.base64EncodedStringWithOptions```.
5. Define a failable convenience initializer that takes a base64 encoded string as a parameter.
6. Implement the initializer by converting the string into ```NSData``` (```NSData(base64EncodedString: String)```) and calling ```self.init(data: NSData)``` with the result.

##### Upload and Download

1. Implement the ```uploadImage``` function by converting the image into a base64 encoded string, creating a Firebase child reference under the "images" endpoint, setting the encoded string as the value, and calling the completion closure with the identifier of the new child.
    * note: Firebase references return the last segment path of the endpoint with a ```.key``` parameter.
2. Implement the ```imageForIdentifier``` function by fetching the data at the "images" endpoint for the image identifier, unwrapping the Base 64 string, initializing the ```UIImage```, and calling the completion closure with the initialized image.

### Black Diamonds

* add 'double tap to like' functionality to the cell

### Tests

## Contributions

Please refer to CONTRIBUTING.md.

## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.