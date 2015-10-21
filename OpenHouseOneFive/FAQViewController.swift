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
        
        
        
    }
    
    func loadJSON(data: NSData) {
        jsonObj = JSON(data: data)
        if jsonObj != JSON.null {
            print("jsonData:\(jsonObj)")
        } else {
            print("invalid JSON file")
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("faqCell");
        let question:UITextView = cell?.viewWithTag(101) as! UITextView
        let answer:UITextView = cell?.viewWithTag(102)as! UITextView
        
        question.scrollEnabled = true
        answer.scrollEnabled = true
        
        question.text = jsonObj["faq"][indexPath.row]["question"].string
        answer.text = jsonObj["faq"][indexPath.row]["answer"].string
        
        //------Calculate size---------
        let fixedWidth = question.frame.size.width
        let newSize = question.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = question.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        question.frame = newFrame;
        
        let fixedWidth2 = answer.frame.size.width
        let newSize2 = answer.sizeThatFits(CGSize(width: fixedWidth2, height: CGFloat.max))
        var newFrame2 = answer.frame
        newFrame2.size = CGSize(width: max(newSize2.width, fixedWidth2), height: newSize2.height)
        answer.frame = newFrame2;
        //------------------------------
        
        return 1.5*question.frame.height + answer.frame.height
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonObj["faq"].count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("faqCell");
        let question:UITextView = cell?.viewWithTag(101) as! UITextView
        let answer:UITextView = cell?.viewWithTag(102)as! UITextView
        
//        question.backgroundColor = UIColor.redColor()
//        answer.backgroundColor = UIColor.blueColor()
        
        let fixedWidth = question.frame.size.width
        let newSize = question.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = question.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        question.frame = newFrame;
        
        let fixedWidth2 = answer.frame.size.width
        let newSize2 = answer.sizeThatFits(CGSize(width: fixedWidth2, height: CGFloat.max))
        var newFrame2 = answer.frame
        newFrame2.size = CGSize(width: max(newSize2.width, fixedWidth2), height: newSize2.height)
        answer.frame = newFrame2;
        
        question.text = jsonObj["faq"][indexPath.row]["question"].string
        answer.text = jsonObj["faq"][indexPath.row]["answer"].string
        
//        print(answer.contentSize.height)
        
        return cell!
        
    }
    
    
}