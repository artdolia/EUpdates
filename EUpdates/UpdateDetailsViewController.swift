//
//  UpdateDetailsViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/17/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class UpdateDetailsViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var cellDataReceived = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateLabel.text = composeDateTimeString(cellDataReceived[0] as NSString)
        self.detailsLabel.text = cellDataReceived[1] as NSString
    
    }

    func composeDateTimeString(initialString: String) -> String{
        
        let dateTimeStringArray = String(cellDataReceived[0] as NSString).componentsSeparatedByString("T")
        let timeStringArray = (dateTimeStringArray[1] as NSString).componentsSeparatedByString(":")
        let dateStringArray = (dateTimeStringArray[0] as NSString).componentsSeparatedByString("-")
        let dateTimeString = ("\(dateStringArray[1])-\(dateStringArray[2])-\(dateStringArray[0]) \(timeStringArray[0]):\(timeStringArray[1])")
        
        return dateTimeString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
