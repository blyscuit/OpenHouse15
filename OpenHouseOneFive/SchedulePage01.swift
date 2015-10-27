//
//  SchedulePage01.swift
//  OpenHouseOneFive
//
//  Created by Romson Preechawit on 27/10/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit

@IBDesignable class SchedulePage01 : UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var titleTest: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        
        configureTableView()
        
        let nib = UINib(nibName: "ScheduleCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "scheduleCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ScheduleCellScript = self.tableView.dequeueReusableCellWithIdentifier("scheduleCell") as! ScheduleCellScript;
        
        cell.titleLabel.text = "Test";
        cell.subtitleLabel.text = "ejrsldfkjsdlkfjkl\nfdsalkjfklsadjf\ndsafhkjsdafhkasd\n"
        
        return cell;
        
        
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }
    
}