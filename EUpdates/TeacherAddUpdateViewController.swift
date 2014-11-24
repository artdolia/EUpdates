//
//  TeacherAddUpdateViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/21/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class TeacherAddUpdateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var updateTextView: UITextView!

    
    //temporary data
    
    var kids = ["All kids", "Art Dolia", "Kyle Blauer", "Zach Shultze"]
    var subjects = ["Math", "Science", "Art"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.composeUpdateString()
    }

    
    //MARK: UIPickerViewDataSource
        
        // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 2
    }
        
        // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if component == 0 {
            return self.kids.count
        }else {
        return self.subjects.count
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if component == 0 {
            return self.kids[row]
        }else {
            return self.subjects[row]
        }

    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        self.composeUpdateString()
    }


    @IBAction func postUpdateAction(sender: UIButton) {
        
        if self.updateTextView.text != ""{
            
            self.postUpdate()
        
        }
        
            
        
    }
    
    func composeUpdateString(){
        
        let who = self.kids[pickerView.selectedRowInComponent(0)]
        let what = self.subjects[pickerView.selectedRowInComponent(1)]
        
        self.updateTextView.text = "\(who) doing \(what.lowercaseString). And we are doing great!"
    }

    
    func postUpdate(){
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-54-68-187-75.us-west-2.compute.amazonaws.com/updates/create/")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["updateText":self.updateTextView.text] as Dictionary<String, String>
        
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
