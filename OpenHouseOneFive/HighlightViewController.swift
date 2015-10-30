//
//  HighlightViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Watchaye on 2015-10-30.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit

class HighlightViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,HighlightViewDelegate {

    var arrayMain = [[String]]()
    @IBOutlet weak var tableMain: UITableView!
    var titleText = ["FACULTIES"]
    var titleImage = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hlJsonParser = HighLightJsonParser()
        arrayMain = hlJsonParser.serializeJSON()
//        print(arrayMain)
        tableMain.delegate = self
        tableMain.dataSource = self
        // Do any additional setup after loading the view.
        
        tableMain.separatorStyle = UITableViewCellSeparatorStyle.None
        
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
            return arrayMain.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            //            let user = self.sections[indexPath.section].users[indexPath.row]
                let cell = tableView.dequeueReusableCellWithIdentifier("highlightCell", forIndexPath: indexPath) as UITableViewCell
            
            var titleImageView = self.view.viewWithTag(100) as? UIImageView
            var labelImage = self.view.viewWithTag(101) as? UIImageView
            var labelTitle = self.view.viewWithTag(102) as? UILabel
            var labelEng = self.view.viewWithTag(103) as? UILabel
            
            //            titleImageView?.image = UIImage()
            labelTitle!.text = arrayMain[indexPath.row][1]
            labelEng!.text = arrayMain[indexPath.row][0]
            let imageName = "\(self.arrayMain[indexPath.row][6]).jpg"
            titleImageView?.image = UIImage(named: imageName)
            titleImageView?.contentMode = UIViewContentMode.ScaleAspectFit

            if(indexPath.row % 2 == 1){
                cell.backgroundColor = UIColor(rgba: "#f9f9f9")
            }
                return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let  headerCell = tableView.dequeueReusableCellWithIdentifier("cellHeader") as? TitleTableViewCell
            headerCell?.titleLabel?.text = titleText[section]
            
            headerCell?.titleImage.image = UIImage(named: titleImage[section])
            return headerCell
        
    }
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let str = "\(facultyVisitArray[indexPath.row].id)"
//        delegate?.mainControllerDidTabWeb(str, controller: self)
        performSegueWithIdentifier("highlightDetail_m", sender: arrayMain[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "highlightDetail_m"){
            let hDVC = segue.destinationViewController as! HighlightDetail
            hDVC.delegate = self
            hDVC.arrDetail = sender as! [String]
        }
    }
    
    func highlightViewClose(controller: HighlightDetail!) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

}
