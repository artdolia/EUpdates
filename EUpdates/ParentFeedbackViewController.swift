//
//  ParentFeedbackViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/21/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class ParentFeedbackViewController: UIViewController {

    //property for text field
    @IBOutlet weak var feedbackTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //need to update the view title each time the view is going back to focus
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.title = "Feedback"
    }
    
    
    @IBAction func clearFeedbackTextButton(sender: UIButton) {
        
        self.feedbackTextField.text = ""
    }
    

    @IBAction func sendFeedbackButton(sender: UIButton) {
        
        //post feedback if the text in the field is present
        if self.feedbackTextField.text != "" {
            self.postUpdate()
        }
    }
    
    
    func postUpdate(){
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-54-68-187-75.us-west-2.compute.amazonaws.com/feedback/create/")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["updateText":self.feedbackTextField.text] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }

}
