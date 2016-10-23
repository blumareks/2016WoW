# My Cognitive App Sentiment

If you like this - give me a star!

Let's build our GUI
Let’s begin by building a simple app with a submit button, an editable text field, and an output field.

This video shows how we will build an iOS app in Xcode to prepare for the Sentiment Analysis:  https://youtu.be/JwdpzO1y8z4

The GUI consists of a text field, a label and a button.  We will implement these in the storyboard.
When the user presses the button, the URL in the text field is sent to Watson which analysis it and returns an opinion which is entered in the label field.
In the first iteration we will take the text in the text field and simply echo it in the label field when we press the button.


## Connect the GUI 

Do the following steps in Main.storyboard to the code in the ViewController file.

### 1. Connect the TextField

In the Main.storyboard:
Double click on the TextField (enter our URL "http://www.huffingtonpost.com/2010/06/22/iphone-4-review-the-worst_n_620714.html")
 1.	Select New Reference Outlet Collection from drop-down list
 2.	Enter textField in the popup dialog.
 3.	Insert between Class ViewController and override… 
 4.	Click Connect
 5.	The result is: 
```swift
@IBOutlet var textField: [UITextField]!
```

### 2. Connect the Button
 1.	Select Touch up Inside from drop-down list
 2.	Enter checkButtonPressed in the popup dialog.
 3.	Insert before the end of the Class ViewController
 4.	Click Connect
 5.	The result is:

The inserted text is:
```swift
@IBAction func checkButtonPressed(sender: AnyObject) {
        
    }
```


### 3. Connect the Text Label


The inserted text is:
```swift
@IBOutlet weak var textStatusLabel: UILabel!
```

Let’s test the code we have written so far:

We will now add some code to the checkButtonPressed method.
```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkButtonPressed(sender: AnyObject) {
        NSLog(textField.text!)
        
        //checking sentiment
        
        //setting feedback on sentiment
        textStatusLabel.text = textField.text
    }
}
```


The NSLog method will allow us to log our actions. And setting the textStatusLabel.text to textField.text will allow us to show the URL from the textField in the Label field.

Now let’s test this by doing a build and execute our app.

We enter the URL in the short text segment in the text field. 
For example: 
- negative sentiment http://www.huffingtonpost.com/2010/06/22/iphone-4-review-the-worst_n_620714.html
- positive : http://www.huffingtonpost.com/2010/06/17/apple-iphone-4-features-t_n_612604.html

This URL is copied to the label field. Once we have added the Watson Service, Watson will return a Sentiment Analysis, which will be displayed in the Label Field.

## The next steps are:
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
```swift
import AlchemyLanguageV1
```
- getting key to Watson service
- updating the code with the final part:
```swift
//checking sentiment with Watson

let apiKey = "<replace it with the AlchemyAPI key>"
let alchemyLanguage = AlchemyLanguage(apiKey: apiKey)

//alchemyLanguage.
let url = textField.text!
let failure = { (error: NSError) in print(error) }

NSLog("calling GetTextsentiment  url         :::::::::::::")
alchemyLanguage.getTextSentiment(forURL: url, failure: failure) { sentiment in
    print(sentiment)
    NSLog((sentiment.docSentiment?.type)!)

    //setting feedback on sentiment
    self.textStatusLabel.text = "text status sentiment ::::::::::::: " + (sentiment.docSentiment?.type)!
}
```

My blog: [blumareks blogspot](http://blumareks.blogspot.com/2016/03/blue-reporter-v21-gets-cognitive-in.html)

My Twitter handle: [@blumareks](https://twitter.com/blumareks)
