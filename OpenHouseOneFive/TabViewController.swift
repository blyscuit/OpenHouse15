//
//  TabViewController.swift
//  OpenHouseOneFive
//
//  Created by Romson Preechawit on 21/10/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController,MainMenuControllerDelegate,MapControllerDelegate,AboutUSViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        //toTutorial()
        if let name = defaults.objectForKey("firstUse")
        {
        }else{
            toTutorial()
            defaults.setBool(true, forKey: "firstUse")
        }

        let logo = UIImage(named: "app_icon_nav_white.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit

        navigationItem.titleView = imageView

        
        var image = UIImage(named: "info_icon_nav_white.png")
        
        //                image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        var homeButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "toAbout")
        
        
        //image = UIImage(named: "user-icon.png")
        //var userButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "toUser")
        
        navigationItem.rightBarButtonItem=homeButton
        //navigationItem.leftBarButtonItem=userButton
        
        for var _tabBarItem in self.tabBar.items!{
            _tabBarItem.title = nil
            _tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            _tabBarItem.image = _tabBarItem.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            _tabBarItem.selectedImage = _tabBarItem.selectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
        }
        
        (viewControllers?.first as! ViewController).delegate = self
        (viewControllers?[1] as! MapViewController).delegate = self
        
    }
    
    func toAbout(){
        print("about")
        performSegueWithIdentifier("toAboutUs", sender: self)
    }
    func toUser(){
        print("user")
    }
    
    func setTopBar(numb:Int){
        switch(numb){
        case 0:
            let logo = UIImage(named: "app_icon_nav_white.png")
            let imageView = UIImageView(image:logo)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            navigationItem.titleView = imageView
            
            
            var image = UIImage(named: "info_icon_nav_white.png")
            
            //                image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
            var homeButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "toAbout")
            
            
            //image = UIImage(named: "user-icon.png")
            //var userButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "toUser")
            
            navigationItem.rightBarButtonItem=homeButton
            //navigationItem.leftBarButtonItem=userButton
        default:
            navigationItem.rightBarButtonItem=nil
            navigationItem.leftBarButtonItem=nil
            
            navigationItem.titleView=nil
        }
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if(tabBar.selectedItem == tabBar.items?[1]){
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
        }
        
        if(tabBar.selectedItem == tabBar.items?[0]){
            setTopBar(0)
            navigationItem.title = nil
        }else if(tabBar.selectedItem == tabBar.items?[1]){
            navigationItem.title = nil
        }else if(tabBar.selectedItem == tabBar.items?[2]){
            setTopBar(2)
            navigationItem.title="Main Stage Schedule"
        }else if(tabBar.selectedItem == tabBar.items?[3]){
            setTopBar(3)
            navigationItem.title="Highlight"
        }else if(tabBar.selectedItem == tabBar.items?[4]){
            setTopBar(4)
            navigationItem.title="FAQ"
            
        }
    }
    
    var toWeb:String!
    func mainControllerDidTabWeb(text: String, controller: ViewController) {
        toWeb = text
        self.performSegueWithIdentifier("web_p", sender: self)
        
    }
    func mapControllerDidTabWeb(text: String, controller: MapViewController) {
        toWeb = text
        self.performSegueWithIdentifier("web_p", sender: self)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    func mapControllerDidAppear(controller: MapViewController) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "web_p"){
            let wVC = segue.destinationViewController as! WebViewController
            wVC.idNumber = toWeb
        }
        else if(segue.identifier == "toAboutUs") {
            let abVC = segue.destinationViewController as! AboutUS
            abVC.delegate = self;
            
        }
    }
    
    func aboutUsViewClose(controller: AboutUS!) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func toTutorial(){
        self.performSegueWithIdentifier("toTutorial", sender: self)
    }

    
}
