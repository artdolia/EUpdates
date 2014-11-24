//
//  ParentFeedbackViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/21/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class ParentFeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func clearFeedbackTextButton(sender: UIButton) {
        
        self.feedbackTextField.text = ""
    }
    

    @IBAction func sendFeedbackButton(sender: UIButton) {
        
        
    }

}
