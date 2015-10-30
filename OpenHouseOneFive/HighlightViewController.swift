//
//  HighlightViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Watchaye on 2015-10-30.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit

class HighlightViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableMain: UITableView!
    var titleText = ["FACULTIES"]
    var titleImage = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableMain.delegate = self
        tableMain.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView)
        -> Int {
            return 1
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return 5
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            //            let user = self.sections[indexPath.section].users[indexPath.row]
                let cell = tableView.dequeueReusableCellWithIdentifier("highlightCell", forIndexPath: indexPath) as UITableViewCell
                
                return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let  headerCell = tableView.dequeueReusableCellWithIdentifier("cellHeader") as? TitleTableViewCell
            headerCell?.titleLabel?.text = titleText[section]
            
            headerCell?.titleImage.image = UIImage(named: titleImage[section])
            return headerCell
        
    }
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(indexPath.section == 2){
            return true
        }
        return false
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let str = "\(facultyVisitArray[indexPath.row].id)"
//        delegate?.mainControllerDidTabWeb(str, controller: self)
    }

}
