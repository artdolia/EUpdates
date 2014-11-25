//
//  UpdateDetailsViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/17/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class UpdateDetailsViewController: UIViewController {
    
    //properties for the ui elements
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    //the data received from the selected row of calling viewController
    var cellDataReceived = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the lables text at view load
        self.dateLabel.text = composeDateTimeString(cellDataReceived[0] as NSString)
        self.detailsLabel.text = cellDataReceived[1] as NSString
    }

    //update the view title each time the view is in the focus
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.title = "Update Details"
    }
    
    func composeDateTimeString(initialString: String) -> String{
        
        //format the string from db to displa the date
        let dateTimeStringArray = String(cellDataReceived[0] as NSString).componentsSeparatedByString("T")
        let timeStringArray = (dateTimeStringArray[1] as NSString).componentsSeparatedByString(":")
        let dateStringArray = (dateTimeStringArray[0] as NSString).componentsSeparatedByString("-")
        let dateTimeString = ("\(dateStringArray[1])-\(dateStringArray[2])-\(dateStringArray[0]) \(timeStringArray[0]):\(timeStringArray[1])")
        
        return dateTimeString
    }

}
