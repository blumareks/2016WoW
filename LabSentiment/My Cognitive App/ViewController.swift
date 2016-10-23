//
//  ViewController.swift
//  My Cognitive App
//
//  Created by Marek Sadowski on 5/10/16.
//  Copyright © 2016 Marek Sadowski. All rights reserved.
//

import UIKit
import AlchemyLanguageV1

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
        
        
        
    }
}

