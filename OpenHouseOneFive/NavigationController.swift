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
        
//        navigationBar.barTintColor = UIColor(rgba:"#FB5986")
//        Replace greenColor with whatever UIColor you want, you can use an RGB too if you prefer.
        
//        Navigation Bar Text:
        
        navigationBar.tintColor = UIColor(rgba:"#FB5986")
        // Do any additional setup after loading the view.
        
        let logo = UIImage(named: "app-icon-nav.png")
        let imageView = UIImageView(image:logo)
        imageView.backgroundColor=UIColor.redColor()
        navigationItem.titleView = imageView
        
        let image = UIImage(named: "info-icon.png")
        
//        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let homeButton : UIBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "toAbout")
        
        navigationItem.rightBarButtonItem=homeButton
    }
    
    func toAbout(){
        print("about")
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

}
