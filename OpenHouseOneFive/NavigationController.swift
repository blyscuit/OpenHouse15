//
//  NavigationController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Wetchaye on 2015-10-16.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        Navigation Bar:
        
        navigationBar.barTintColor = UIColor(rgba:"#FB5986")
//        Replace greenColor with whatever UIColor you want, you can use an RGB too if you prefer.
        
//        Navigation Bar Text:
        
        navigationBar.tintColor = UIColor(rgba:"#ffffff")
        // Do any additional setup after loading the view.
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func shouldAutorotate() -> Bool {
//        return false
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
