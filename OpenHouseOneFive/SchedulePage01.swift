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
        
        //for testing
//        let currentTime = parseDateFromJSON("2015-11-16T12:00:00+07:00")
        
        let currentTime = NSDate()
        
        //====================
        let activeCellColor = UIColor(red: 1, green: 213.0/255.0, blue: 7.0/255.0, alpha: 1)
        let inactiveCellColor = UIColor(red: 201.0/255.0, green: 201.0/255.0, blue: 201.0/255.0, alpha: 1)
        //====================
        
        var isLast = false;
        
        let cell:ScheduleCellScript = self.tableView.dequeueReusableCellWithIdentifier("scheduleCell") as! ScheduleCellScript;
        
        let dateNS = parseDateFromJSON(schedule[indexPath.row]["time"].string!)
        
        var dateNSNext:NSDate?
        
        if(indexPath.row+1<schedule.count){
            dateNSNext = parseDateFromJSON(schedule[indexPath.row+1]["time"].string!)
        } else {
            isLast = true
        }
        
        
        cell.timeLabel.text = getTimeFromDateObj(dateNS)
        cell.titleLabel.text = schedule[indexPath.row]["title"].string
        cell.subtitleLabel.text
        = schedule[indexPath.row]["subtitle"].string
        
        //deal with it own data
        if(dateNS.isAfterDate(currentTime)) {
            //is inactive
            cell.barTop.backgroundColor = inactiveCellColor
            cell.barTopB.backgroundColor = inactiveCellColor
            
            let tintedImage:UIImage = UIImage(named: "dotInactive")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            cell.dot.image = tintedImage;
            cell.dot.tintColor = inactiveCellColor
            
        } else {
            cell.barTop.backgroundColor = activeCellColor
            cell.barTopB.backgroundColor = activeCellColor
            
            let tintedImage:UIImage = UIImage(named: "dotActive")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            cell.dot.image = tintedImage;
            cell.dot.tintColor = activeCellColor
        }
        
        //if the cell below is not active then color gray
        if(!isLast){
            if(dateNSNext!.isAfterDate(currentTime)){
                //if below is active
                cell.barBottom.backgroundColor = inactiveCellColor
            } else {
                cell.barBottom.backgroundColor = activeCellColor
            }
            
        } else {
            //set bottom bar to transparent
            cell.barBottom.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            cell.barTop.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
        
//        if(indexPath.row == 0){
//            cell.barTopB.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//        }
        
        
        return cell;
        
        
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80.0
        tableView.contentInset.bottom = 50.0
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