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
    }
    
    func composeUpdateString(){
        
        let who = self.kids[pickerView.selectedRowInComponent(0)]
        let what = self.subjects[pickerView.selectedRowInComponent(1)]
        
        self.updateTextView.text = "\(who) doing \(what.lowercaseString). And we are doing great!"
    }
}
