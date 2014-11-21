//
//  TeacherUpdatesViewController.swift
//  EUpdates
//
//  Created by Artsiom Dolia on 11/21/14.
//  Copyright (c) 2014 Artsiom Dolia. All rights reserved.
//

import UIKit

class TeacherUpdatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var tableData = []
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let tFrame = self.view.bounds
        let tableView = UITableView(frame: tFrame)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsetsMake(230, 0, 100, 0)
        
        self.view.addSubview(tableView)
        
        self.tableView = tableView
        
        //self.setActivityName(actions[0])
        
        fetchJson()

    }
    
    //MARK: UITableViewDataSource
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
//        
//        return "Updates List"
//        
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //println(self.tableData.count)
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        //println("\(indexPath.row) \(rowData)")
        
        var fields: NSDictionary = rowData["fields"] as NSDictionary
        var updateText:NSString = fields["updateText"] as NSString
        var updateTime:NSString = fields["updateTime"] as NSString
        cell.textLabel.text = updateText
        cell.detailTextLabel?.text = updateTime
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        //println("\(tableView.indexPathForCell(cell))")
        cell.setSelected(false, animated: true)
        self.performSegueWithIdentifier("teacherUpdateToDetails", sender: self)
    }

    
    //MARK: JSON
    
    func fetchJson(){
        
        //let urlPath = "http://citibikenyc.com/stations/json"
        
        let urlPath = "http://ec2-54-68-187-75.us-west-2.compute.amazonaws.com/updates/json/"
        
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            println("Task completed")
            
            if error != nil {
                println(error.localizedDescription)
            }
            
            var err: NSError?
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            
            //println(jsonResult)
            
            if(err != nil){
                
                println("JSON Error \(err!.localizedDescription) ")
            }
            
            //let result: NSArray = jsonResult["stationBeanList"] as NSArray
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableData = jsonResult
                self.tableView!.reloadData()
                //println(self.tableData)
            })
        })
        
        task.resume()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "teacherUpdateToDetails" {
            
            //prepare data array to pass
            
            let selectedRowIndex = self.tableView!.indexPathForSelectedRow()!.row
            let selectedRowDict = self.tableData[selectedRowIndex] as NSDictionary
            let selectedField = selectedRowDict["fields"] as NSDictionary
            var updateText:NSString = selectedField["updateText"] as NSString
            var updateTime:NSString = selectedField["updateTime"] as NSString
            let arrayToPass = [updateTime, updateText]
            
            //get the destination view controller and pass the array
            
            let destinationViewController: UpdateDetailsViewController = segue.destinationViewController as UpdateDetailsViewController
            
            destinationViewController.cellDataReceived = arrayToPass
            
        }
    }

    
    
    @IBAction func addUpdateButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("teacherUpdatesToAdd", sender: self)
    }
    

}
