# My Cognitive App Visual

Let's build our GUI

Let’s begin by building a simple app with a submit button, an editable text field, and an output field.

This video shows how we will build an iOS app in Xcode to prepare for the Visual Analysis: https://youtu.be/GcXXm8UId4A

The GUI consists of a text field, a label and a button.  We will implement these in the storyboard.
When the user presses the button, the URL in the text field is sent to Watson which analysis the provided picture in the URL and returns a resulting analysis  in the JSON form of the image with a confidence score.
In the first iteration we will take the text in the text field and simply echo it in the label field when we press the button.

## Connect the GUI in Main.storyboard to the code in the ViewController file:

### 1. Connect the TextField
We are going to analyse this picture:
https://farm4.staticflickr.com/3754/11702702564_1fc3c669ba_m.jpg

In the Main.storyboard:

Right-click on the TextField (contains the URL to a graphics file of your choice)
1.	Select New Reference Outlet Collection from drop-down list
2.	Enter urlText as the Name  in the popup dialog.
3.	Insert between Class ViewController and override… 
4.	Click Connect
5.	The result is: 
```swift
@IBOutlet var urlText: [UITextField]!
```

### 2. Connect the Label Field

Right-click on the LabelField (Currently empty)
1.	Select New Reference Outlet Collection from drop-down list
2.	Enter analysisTextLabel as the Name  in the popup dialog.
3.	Insert after the urlText  
4.	Click Connect
5.	The result is: 
```swift
@IBOutlet var analysislTextLabel: [UITextField]!
```

### 3. Connect the Button
Right-click on the Button 
1.	Select Touch Up Inside from drop-down list
2.	Enter analysisButtonPressed as the Name  in the popup dialog.
3.	Insert at the end of the  ViewController Class
4.	Click Connect
5.	The result is: 
```swift
@IBAction func analysisButtonPressed(sender: AnyObject) {            
}
```

We will now add some code to the analysisButtonPressed method.
```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var analysisTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func analysisButtonPressed(sender: AnyObject) {
        NSLog("Button pressed")
        NSLog("URL: "+urlText.text!)
        analysisTextLabel.text="Analysis of the URL " + urlText.text!
        
    }
}
```

The NSLog method will allow us to log our actions. And setting the textStatusLabel.text to textField.text will allow us to show the output from the textField in the Label field.

Now let’s test this by doing a build and execute our app.

We enter a url to an image file in the text field. This name is printed to the log file. Once we have added the Watson Service, Watson will return an analysis of the image to the label field.

We press the Visual Analysis button to see the output in the Log area.

The next steps are:
- adding the carthage package manager to get Watson Developer Cloud SDK for iOS and running carthage update --platform iOS - see readme.md
- extending the info.plist with access to watson.net over http
```xml
<key>NSAppTransportSecurity</key>
<dict>
<key>NSExceptionDomains</key>
<dict>
<key>watsonplatform.net</key>
<dict>
<key>NSTemporaryExceptionRequiresForwardSecrecy</key>
<false/>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
<true/>
</dict>
</dict>
</dict>
```
- getting import with Watson service
- getting key to Watson service
- updating the code with the final part:
```swift

var status = "waiting for Watson processing the URL : " + urlText.text!

//Adding Watson Visual Recognition - based on the example from WDC sdk iOS
let apiKey = "<enter the Watson APIKey here>"
let version = "2016-05-22" // use today's date for the most recent version
let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)

let url = urlText.text!
let failure = { (error: NSError) in print(error) }
visualRecognition.classify(url, failure: failure) { classifiedImages in
    status = "visual status ::::::::::::: " + (classifiedImages.images.description)

    //detecting classification
    if (!classifiedImages.images.isEmpty && !classifiedImages.images[0].classifiers.isEmpty &&
    !classifiedImages.images[0].classifiers[0].classes.isEmpty) {
        status = status + "######## classification : " + classifiedImages.images[0].classifiers[0].classes[0].classification

        //detecting faces on the pictures with people
        if (!classifiedImages.images[0].classifiers[0].classes[0].classification.isEmpty &&
            "person" == classifiedImages.images[0].classifiers[0].classes[0].classification) {
            self.analysisTextLabel.text = status + " ##########  person found ###########"
            visualRecognition.detectFaces(url, failure: failure) { imagesWithFaces in
                if (!imagesWithFaces.images[0].faces.isEmpty) {
                    status = status + " ###### the person's age max : " + imagesWithFaces.images[0].faces[0].age.max.description
                        status = status + " age min : " + imagesWithFaces.images[0].faces[0].age.min.description
                        status = status + " person's gender : " + imagesWithFaces.images[0].faces[0].gender.gender
                        NSLog("faces :::::::::::::: ")
                        self.analysisTextLabel.text = "3 : " + status
                }
            }
        }
    }
    //setting feedback on sentiment
    self.analysisTextLabel.text = "2 : " + status
}
//setting feedback on sentiment
self.analysisTextLabel.text = "1 : " + status
}

```

check these links:
person with age: http://g1.computerworld.pl/news/thumbnails/2/6/265397_resize_620x460.jpg
person = https://static.sched.org/a6/1606352/avatar.jpg.320x320px.jpg?3c4
beach: http://1.bp.blogspot.com/_dWmIOlGB7_0/S9nvqlTPz9I/AAAAAAAADCw/PRmRH_UPseI/s1600/beach+palm+trees+%283%29.jpg
hiking: http://www.backpaco.com/wp-content/uploads/2015/04/yosemite-park.jpg
tatry: http://s3.flog.pl/media/foto/5654654_tatry-dolina-pieciu-stawow-polskich-widok-z-gory.jpg
diving: http://www.nautica.pl/images/phocagallery/safari_warsztat_foto/thumbs/phoca_thumb_l_warsztaty_fotograficzne_egipt2.jpg
diving: http://www.nautica.pl/images/phocagallery/safari_warsztat_foto/thumbs/phoca_thumb_l_warsztaty_fotograficzne_egipt3.jpg
camping: http://cospuente.org/images/351.jpg
skiing: https://murowanica.files.wordpress.com/2013/12/rersdtfghj.jpg


My blog: [blumareks blogspot](http://blumareks.blogspot.com/2016/03/blue-reporter-v21-gets-cognitive-in.html)

My Twitter handle: [@blumareks](https://twitter.com/blumareks)
