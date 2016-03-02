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



























## Part Five - Implement Controllers

* upload photos to Firebase as base64 strings
* asynchronously download photos to display
* authenticate users anonymously or via e-mail

### UserController Implementation
 

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