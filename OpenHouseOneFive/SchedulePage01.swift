//
//  SchedulePage01.swift
//  OpenHouseOneFive
//
//  Created by Romson Preechawit on 27/10/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable class SchedulePage01 : UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var schedule:JSON = []
    
    
    @IBOutlet var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        
        configureTableView()
        
        print("received\(schedule)")
        
        let nib = UINib(nibName: "ScheduleCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "scheduleCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ScheduleCellScript = self.tableView.dequeueReusableCellWithIdentifier("scheduleCell") as! ScheduleCellScript;
        cell.timeLabel.text = timeFromJSON(schedule[indexPath.row]["time"].string!)
        cell.titleLabel.text = schedule[indexPath.row]["title"].string
        cell.subtitleLabel.text = schedule[indexPath.row]["subtitle"].string
        
        return cell;
        
        
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }
    
    func parseDateFromJSON(date:String) -> NSDate {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFor.dateFromString(date)!
    }
    
    func getTimeFromDateObj(date:NSDate) -> String{
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "h:mm a"
        return dateFor.stringFromDate(date)
    }
    
    func timeFromJSON(dateString:String) -> String{
        return getTimeFromDateObj(parseDateFromJSON(dateString))
    }
    
    
}