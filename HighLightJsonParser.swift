//
//  HighLightJsonParser.swift
//  OpenHouseOneFive
//
//  Created by Thanat Jatuphattharachat on 10/30/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit
import SwiftyJSON

class HighLightJsonParser: NSObject {
    
    let HIGHLIGHT_JSON_FILE = "highlight"
    var jsonObj: JSON = []
    
    func serializeJSON() -> [[String]] {
       
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
        
        return arrDetail
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
