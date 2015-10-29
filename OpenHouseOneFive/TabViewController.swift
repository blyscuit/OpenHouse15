//
//  TabViewController.swift
//  OpenHouseOneFive
//
//  Created by Romson Preechawit on 21/10/2558 BE.
//  Copyright © 2558 Thinc. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "app-icon-nav.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        //        imageView.backgroundColor=UIColor.redColor()
        navigationItem.titleView = imageView
        //        UINavigationBar.appearance().setBackgroundImage(logo, forBarMetrics: UIBarMetrics.Default)
        
        var image = UIImage(named: "info-icon.png")
        
        //        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let homeButton : UIBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "toAbout")
        
        
        image = UIImage(named: "user-icon.png")
        let userButton : UIBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "toUser")
        
        navigationItem.rightBarButtonItem=homeButton
        navigationItem.leftBarButtonItem=userButton
        
        for var _tabBarItem in self.tabBar.items!{
            _tabBarItem.title = nil
            _tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            _tabBarItem.image = _tabBarItem.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            _tabBarItem.selectedImage = _tabBarItem.selectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
        }
        

    }
    
    func toAbout(){
        print("about")
    }
    func toUser(){
        print("user")
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if(tabBar.selectedItem == tabBar.items?[1]){
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
        }
    }
    
    
}
