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

## Part Four - Implement Controllers

* use Firebase as a backend for storing and pulling model objects
* implement the Firebase controller and model object controllers to work with live data
* implement a custom protocol for Firebase model objects, controllers, and live updating views

It is time to implement actual funtionality for our controller objects. You will import the Firebase library into the application, create a reusable ```FirebaseController``` helper class that will perform basic Firebase interactions for authentication and fetching and pushing data, and get the model objects ready to save to Firebase by writing and implementing a ```FirebaseType``` protocol.

### Add Firebase to the Project























































##### Define the Protocol


##### Extend the Protocol


### Adopt the FirebaseType Protocol



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