//
//  ScheduleBaseView.swift
//  OpenHouseOneFive
//
//  Created by Romson Preechawit on 27/10/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScheduleBaseView :  UIViewController ,CAPSPageMenuDelegate {
    
    let FAQ_JSON_FILE = "Schedule"
    var jsonObj: JSON = []
    
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        
        
        loadJSONFile();
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        var controller : SchedulePage01;
        
        for var jsonDateSch:JSON in jsonObj["open_house"].array!{
            
            let date = jsonDateSch["date"].string
            
            let dateObj = parseDateFromJSON(date!)
            
            controller = SchedulePage01(nibName: "SchedulePage", bundle: nil)
            controller.title = getDateString(dateObj);
            controllerArray.append(controller)
            
        }
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .ScrollMenuBackgroundColor(UIColor(rgba:"#FB5986")),
            .BottomMenuHairlineColor(UIColor(red: 193.0/255.0, green: 16.0/255.0, blue: 88.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor(red: 193.0/255.0, green: 16.0/255.0, blue: 88.0/255.0, alpha: 1.0)),
            .MenuMargin(20.0),
            .MenuHeight(40.0),
            .SelectedMenuItemLabelColor(UIColor.whiteColor()),
            .UnselectedMenuItemLabelColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6)),
            .MenuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorRoundEdges(false),
            .MenuItemSeparatorColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0)),
            .SelectionIndicatorHeight(2.0),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 60.0, self.view.frame.width, self.view.frame.height-60), pageMenuOptions: parameters)
        
        pageMenu!.delegate = self;

        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
        

    }
    
    
    func parseDateFromJSON(date:String) -> NSDate {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFor.dateFromString(date)!
    }
    
    func getDateString(date:NSDate) -> String{
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "dd MMMM"
        return dateFor.stringFromDate(date)
    }
    
    
    func loadJSONFile(){
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
    
}
