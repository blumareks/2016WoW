//
//  ViewController.swift
//  My Cognitive App
//
//  Created by Marek Sadowski on 5/10/16.
//  Copyright © 2016 Marek Sadowski. All rights reserved.
//

import UIKit
import TextToSpeechV1 //importing Watson TTS service 
import AVFoundation   //importing AVFoundation for AVAudioPlayer

class ViewController: UIViewController {

    @IBOutlet weak var speakText: UITextField!
    @IBOutlet weak var voiceSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func speakButtonPressed(sender: AnyObject) {
        NSLog("Speak button pressed, speak:" + speakText.text! + "voice segment" + voiceSegment.selectedSegmentIndex.description)
        
        //add Watson Service
        
        let username = "<user from Watson TTS service>"
        let password = "<password from Watson TTS service>"
        let textToSpeech = TextToSpeech(username: username, password: password)
        
        let text = speakText.text!
        let failure = { (error: NSError) in print(error) }
        textToSpeech.synthesize(text, voice: ("0"==voiceSegment.selectedSegmentIndex.description ? SynthesisVoice.US_Michael : ( "1"==voiceSegment.selectedSegmentIndex.description ? SynthesisVoice.US_Allison : SynthesisVoice.GB_Kate)), failure: failure) { data in
            do {
                var audioPlayer: AVAudioPlayer // see note below
                audioPlayer = try! AVAudioPlayer(data: data)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                sleep(10)
                // A note about AVAudioPlayer: The AVAudioPlayer object will stop playing
                // if it falls out-of-scope. Therefore, it's important to declare it as a
                // property or otherwise keep it in-scope beyond the completion handler.
                
            } catch {
                NSLog("something went terribly wrong")
            }
            
        }
    }
    
}

