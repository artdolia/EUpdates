//
//  ViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/17/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //MARK: buttons actions
    
    @IBAction func resetButtonAction(sender: UIButton) {
        
        self.userNameField.text = ""
        self.passwordField.text = ""
    }
    
    @IBAction func loginButtonAction(sender: UIButton) {
        
        self.performSegueWithIdentifier("loginToParent", sender: self)
    }
    


}

