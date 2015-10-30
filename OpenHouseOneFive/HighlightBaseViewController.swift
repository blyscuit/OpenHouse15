//
//  HighlightBaseViewController.swift
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 10/29/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit
import SwiftyJSON

class HighlightBaseViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    let HIGHLIGHT_JSON_FILE = "highlight"
    var jsonObj: JSON = []

    
    @IBOutlet
    var highlightTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJSONFile();
        var arrDetail : [[String]] = [[String]]()
        loadJSONFile();
       
        for var jsonDetail:JSON in jsonObj["open_house_highlight"].array!{
            
            
            var row = [String]()
            var artPic = jsonDetail["Artwork_name"].stringValue
            var lat = jsonDetail["Latitude"].stringValue
            var long = jsonDetail["Logitude"].stringValue
            var fac = jsonDetail["Faculty"].stringValue
            var location = jsonDetail["Location"].stringValue
            var external = jsonDetail["ExternalLink"].stringValue
            var title = jsonDetail["Title"].stringValue
            var highlight = jsonDetail["Highlight"].stringValue
            
            row.append(fac)
            row.append(title)
            row.append(location)
            row.append(highlight)
            row.append(artPic)
            row.append(lat)
            row.append(long)
            row.append(external)
            
            arrDetail.append(row)
            
            
        }
        print(arrDetail[1][0])
                
                
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func loadJSONFile(){
        if let path = NSBundle.mainBundle().pathForResource(HIGHLIGHT_JSON_FILE, ofType: "json"){
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

}
