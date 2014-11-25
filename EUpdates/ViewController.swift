//
//  ViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/17/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //properties for the ui elements from storyboard
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: buttons actions
    
    @IBAction func resetButtonAction(sender: UIButton) {
        self.clearFields()
    }
    
    
    @IBAction func loginButtonAction(sender: UIButton) {
        
        //hardcoded strings to recognize parent or teacher
        if self.userNameField.text == "parent" {
            
            self.performSegueWithIdentifier("loginToTabParent", sender: self)
            
        }else if self.userNameField.text == "teacher" {
            
            self.performSegueWithIdentifier("loginToTabTeacher", sender: self)
        }
        
        self.clearFields()
    }
    
    func clearFields(){
        self.userNameField.text = ""
        self.passwordField.text = ""
    }
}

