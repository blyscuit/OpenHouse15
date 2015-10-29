//
//  FAQ-ViewController.swift
//  OpenHouseOneFive
//
//  Created by Romson Preechawit on 21/10/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit
import SwiftyJSON

class FAQViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let FAQ_JSON_FILE = "FAQ"
    var jsonObj: JSON = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        print("FAQ View Loaded")
        if let path = NSBundle.mainBundle().pathForResource(FAQ_JSON_FILE, ofType: "json"){
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                loadJSON(data);
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
        } else {
            print("Invaild filename/path!")
        }
        
        configureTableView()
        
        
    }
    
    func loadJSON(data: NSData) {
        jsonObj = JSON(data: data)
        if jsonObj != JSON.null {
            print("jsonData:\(jsonObj)")
        } else {
            print("invalid JSON file")
        }

    }
    

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonObj["faq"].count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("faqCell");
        let question:UITextView = cell?.viewWithTag(101) as! UITextView
        let answer:UITextView = cell?.viewWithTag(102)as! UITextView

        
        question.text = jsonObj["faq"][indexPath.row]["question"].string
        answer.text = jsonObj["faq"][indexPath.row]["answer"].string

        
        return cell!
        
    }
    
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        tableView.contentInset.bottom = 49
    }
    
}