# 2016WoW
Swift base examples for iOS apps using Watson in a quick espresso style.

**If you like it - give me a star!**

The prereqs:
- XCode 8.0 or greater (however at the moment **IBM Watson SDK requires that we use Swift 2.3** )
- Carthage (the package manager to get IBM Watson SDK) - please see below

Please find the GUIs for the 3 SWIFT - Watson LABs:
- [My Cognitive Sentiment](https://github.com/blumareks/2016WoW/tree/master/LabSentiment)
- [My Cognitive Visual](https://github.com/blumareks/2016WoW/tree/master/LabVisual)
- [My Cognitive Text-to-Speech](https://github.com/blumareks/2016WoW/tree/master/LabTTS)

As soon as you fork each of the labs you might want to run Carthage to enable Watson SDK frameworks needed in your Swift application. You need to run with the following command from the command line at the root of the project: 
```
carthage update --platform iOS
```

The next step is to add required frameworks


## Installing and running Carthage
The initial setup of the Carthage is the following:

https://github.com/Carthage/Carthage#installing-carthage

We will use the Carthage dependency manager to install libraries used by our app.
To install Carthage on our system, we will download and run the latest release of the Carthage.pkg file: https://github.com/Carthage/Carthage/releases , then follow the on-screen instructions.

Alternatively, only on Xcode 7.x, we can use Homebrew and install the Carthage tool on our system simply by running brew update and brew install carthage. (note: if you previously installed the binary version of Carthage, you should delete /Library/Frameworks/CarthageKit.framework).

If you’d like to run the latest development version (which may be highly unstable or incompatible), simply clone the master branch of the repository, then run make install.

[The process of setting up the environment in a youtube video.](https://youtu.be/mRUVzehJIpU)

### Install the Watson SDK
- In a Bash shell in the root directory of your project run:
```
cat > cartfile
```
- Enter the following line:
```
github "watson-developer-cloud/ios-sdk"
```
- Enter a new line
- Enter "control+C" to leave the edit

from the command line at the root of the project run the command: 
```
carthage update --platform iOS
```
If you receive a compile failure for the framework AlamofireObjectMapper, run the command again.

- Getting all the dependencies to the project with the help of the Carthage:

The process will issue “Fetching”, “Checking out” and “Building scheme” messages for the library components, including at the end a set of warnings that can be ignored. 



### Add the SDK to the Xcode project

Create a new Group in your Xcode project called "Framework" under the project name.
And select all the framework files in the Carthage/Build/iOS/ directory of your project (required Watson library framework, Alamofire, RestKit, Freddy, Starscream). Drag-and-drop those files from Finder into the new "Framework" group inside of your project in Xcode. When the dialog appears, make sure you deselect the option to copy items. This will create a reference to those Framework files without copying them.

This is the list of the framework libraries:

- for **Sentiment analysis**

![framework libraries for sentiment](https://github.com/blumareks/2016WoW/blob/master/images/SentimentFrameworks.png "framework libraries for sentiment")

- an alternative setup for framework libraries for **Text To Speech**:

![framework libraries for TTS](https://github.com/blumareks/2016WoW/blob/master/images/TTSFrameworks.png "framework libraries for TTS")

- and for the visual analysis:
![framework libraries for Visual](https://github.com/blumareks/2016WoW/blob/master/images/VisualFrameworks.png "framework libraries for Visual Analysis")


Build target. In the "Build Phases" tab, add a new Copy Files Phase and set its destination to "Frameworks".
Copy all the frameworks that have been added one by one.

Section in Build Phases: "Copy Files" - Add all of the frameworks you added to Xcode to the Copy Files Phase - see the result below (for Sentiment Analysis Watson service):

![alt text](https://github.com/blumareks/2016WoW/blob/master/images/TTSFrameworks_copyphase.png "Copy Files")



We will now update info.plist with the ability to call outside services of Watson.Add the following to your info.plist. In order to make network calls to Watson, we need to whitelist the URL to the watsonplatform.net server.
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

![alt text](https://2.bp.blogspot.com/-5eM1XYycYJk/V0duGPihzsI/AAAAAAAAArw/777t2WdU39UoJv8IbIF_5lNMp1eLCeQpQCLcB/s1600/WhitelistingWatson.png "Copy Files")




## References

The version for the same labs with Java/Android could be found here:
- [blumareks' repo: 2016EduHackathon_SanFrancisco](https://github.com/blumareks/2016EduHackathon_SanFrancisco)

Please follow me on Twitter: [@blumareks](https://twitter.com/blumareks), and check my blog on [blumareks.blogspot.com](http://blumareks.blogspot.com/)

