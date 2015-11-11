//
//  ViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Watchaye on 2015-10-12.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

@objc protocol MainMenuControllerDelegate {
    func mainControllerDidTabWeb(text: String, controller: ViewController)
//    func bingoControllerDidTapCell(controller: ViewController)
}
class ViewController: UIViewController, QRCodeReaderViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,BingoViewControllerDelegate{
    
    var delegate: MainMenuControllerDelegate?
    
    @IBOutlet weak var tableMain: UITableView!
    
    @IBOutlet weak var qrInstructionLabel: UILabel!
    
    var facultyArray:[Tile]!
    var facultyVisitArray:[Tile]!
    
    
    var bingoCell:BingoViewController!
    
    let titleText = ["N O W  E V E N T","C H E C K  I N","Visited faculties","Locked faculties — Check in to unlock "]
    let titleImage = ["now-event-icon.png","check-in-icon.png"]
    
//    var bingoBoard:Bingo!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadJSONFile()
        
        
        tableMain.delegate = self
        tableMain.dataSource = self
        
//        bingoBoard = Bingo(random: true)
        genFacArray()
//        bingoTable.frame.size = CGSizeMake(bingoTable.frame.size.width, bingoTable.frame.size.width)
        
//        bingoTable.reloadData()
        
        //JSON
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "MainMenu")
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
        
    }
    
    func genFacArray(){
                
        facultyArray = [Tile]()
        facultyVisitArray = [Tile]()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let tile = appDelegate.bingo.tileAtColumn(column, row: row){
                    if((tile.got) == true){
                        facultyVisitArray.append(tile)
                    }else{
                        facultyArray.append(tile)
                    }
                }
            }
        }
//        bingoBoard.gotTile(bingoBoard.tileAtColumn(0, row: 4)!)
        appDelegate.bingo.saveDataToUser()

        tableMain.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var reader = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
    
    @IBAction func scanAction(sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            
            reader.completionBlock = { (result: String?) in
                print("Completion with result: \(result)")
            }
            
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: String) {
        self.dismissViewControllerAnimated(true, completion: { [unowned self] () -> Void in
            
            var mess:String?
            var alertMsg:String?
            
            if let tile = self.appDelegate.bingo.gotTileWithQR(result){
                 mess = "\(tile.name!) \n\(tile.thaiName!)"
                self.appDelegate.bingo.saveDataToUser()
                print("Scan success I'm going to unlock the tile")
                
                var tracker = GAI.sharedInstance().defaultTracker
                
                tracker.send(GAIDictionaryBuilder.createEventWithCategory("QR", action: "Scanned", label: "mess", value: nil).build() as [NSObject : AnyObject])
                alertMsg = "Faculty is Unlocked"
            }else{
                mess = "Please try again"
                alertMsg = "Incorrect QR code"
                
            }
            
            let alert = UIAlertController(title:  alertMsg, message: mess!, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            //add image to alertView
//            let imageView : UIImageView = UIImageView(image:UIImage(named: "activeTable_21.png"))
//            imageView.frameForAlignmentRect(CGRectMake(100, 0, 30 , 30))
//            alert.view.addSubview(imageView)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            self.genFacArray()
            })
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView)
        -> Int {
            return 4;
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            if(section == 0||section == 1){
                return 1
            }
            else if(section == 2){
                return facultyVisitArray.count
            }
            return facultyArray.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            //let user = self.sections[indexPath.section].users[indexPath.row]
            var isActiveCell:Bool = false
            if(indexPath.section==0){
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
            
                setNowEvent(cell.textLabel, detailLabel: cell.detailTextLabel)
                
            
            return cell
            }else if(indexPath.section==1){
                let cell = tableView.dequeueReusableCellWithIdentifier("bingoCell", forIndexPath: indexPath) as! BingoViewController
//                cell.bingoBoard = self.appDelegate.bingo
                bingoCell = cell
                cell.delegate = self
                cell.start()
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("facultyStatusCell", forIndexPath: indexPath) as! TitleTableViewCell
                let tile:Tile!
                if(indexPath.section == 2){
                    //tile in visited Faculty
                    tile = facultyVisitArray[indexPath.row]
                    isActiveCell = true
                    tableMain.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                    tableMain.separatorInset = UIEdgeInsetsZero
                    cell.backgroundColor = UIColor.whiteColor()
                    cell.titleLabel.textColor = UIColor.blackColor()
                    cell.subTitleLabel.textColor = UIColor.blackColor()
                    
                }else{
                    //tile for unvisited faculty
                    tile = facultyArray[indexPath.row]
                    tableMain.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                    tableMain.separatorInset = UIEdgeInsetsZero
                    cell.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
                    cell.titleLabel.textColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
                    cell.subTitleLabel.textColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
                }
                cell.titleLabel.text = tile.thaiName
                cell.subTitleLabel.text = tile.name
                

                if(isActiveCell) {
                    cell.imageView?.image = UIImage(named: "activeTable_\(tile.id).png")
                }
                else {
                    cell.imageView?.image = UIImage(named: "inactiveTable_\(tile.id).png")
                }
                
                if(tile.id == 41 || tile.id == 42 || tile.id == 43) {
                    
                }
                //print("this is tile.id \(tile.id)")
                return cell
            }
    }

    
    /* section headers
    appear above each `UITableView` section */
    //    func tableView(tableView: UITableView,
    //        titleForHeaderInSection section: Int)
    //        -> String {
    //            // do not display empty `Section`s
    ////            if !self.sections[section].users.isEmpty {
    ////                return self.collation.sectionTitles[section] as String
    ////            }
    //
    //            let group:NSArray! = peopleData.valueForKey("group") as! NSArray
    //            let groupD:NSDictionary! = group[section] as! NSDictionary
    //            let name:String! = groupD.valueForKey("-name") as! String
    //
    //            return name
    //    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section<=1){
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("cellHeader") as? TitleTableViewCell
        headerCell?.titleLabel?.text = titleText[section]
        
            headerCell?.titleImage.image = UIImage(named: titleImage[section])
            return headerCell
        }else{
            let  headerCell = tableView.dequeueReusableCellWithIdentifier("facultyCell") as? TitleTableViewCell
            if(section==3){
                var myMutableString = NSMutableAttributedString()
                myMutableString = NSMutableAttributedString(string: titleText[section])
                // NSMutableAttributedString(
                //string: "Explore more faculty and scan QR Code to unlock a prize.",
                //attributes: [NSFontAttributeName:UIFont(
                //    name: "Georgia",
                //    size: 18.0)!])
                //Add more attributes here
                
                if #available(iOS 8.2, *) {
                    myMutableString.addAttribute(NSFontAttributeName,
                        value: UIFont.systemFontOfSize(13, weight: 0.05),
                        range: NSRange(
                            location: 16,
                            length: 22))
                } else {
                    // Fallback on earlier versions
                }
                myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(16, 22))
                headerCell?.titleLabel.attributedText = myMutableString
            }else{
                headerCell?.titleLabel?.text = titleText[section]
            }
            
            return headerCell
        }
    }
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(indexPath.section == 2){
            return true
        }
        return false
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 65;
        }else if(indexPath.section==1){
            return self.view.frame.size.width + 125;
        }else if(indexPath.section == 2){
            //hide those row whose
            if(facultyVisitArray[indexPath.row].id >= 41) {
                return 0
            }
            
        } else if(indexPath.section == 3) {
            if(facultyArray[indexPath.row].id >= 41) {
                return 0
            }
        }
        return 58
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if facultyVisitArray[indexPath.row].id > 40{
            return
        }
        let str = "\(facultyVisitArray[indexPath.row].id)"
        delegate?.mainControllerDidTabWeb(str, controller: self)
    }
    
    // MARK: - bingo view data source
    func bingoControllerDidCheckIn(controller: BingoViewController) {
        self.scanAction(self)
    }
    func bingoControllerDidTapCell(tile: Tile, controller: BingoViewController) {
        if tile.id > 40{
            return
        }
        if tile.got{
            let str = "\(tile.id)"
            delegate?.mainControllerDidTabWeb(str, controller: self)
        }
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        tableMain.reloadData()
    }
    
    //JSON
    
    let JSON_FILE = "Schedule"
    var jsonObj: JSON = []
    
    func loadJSONFile(){
        if let path = NSBundle.mainBundle().pathForResource(JSON_FILE, ofType: "json"){
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                loadJSON(data);
                
            } catch let error as NSError {
                print(error.localizedDescription)
            } catch {
                print("other error")
            }
            
            
            
        } else {
            print("Invaild filename/path!")
        }
    }
    
    func loadJSON(data: NSData) {
        jsonObj = JSON(data: data)
        if jsonObj != JSON.null {
            print("jsonData:\(jsonObj)")
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            for var subJSON:JSON in jsonObj["open_house"].array!{
                for var scheduleJSON:JSON in subJSON["schedule"].array!{
                    let dateObj = parseDateFromJSON(scheduleJSON["time"].string!)
                    setNotification(scheduleJSON["title"].string!, dateToFire: dateObj)
                }
            }
            
            
            
            
        } else {
            print("invalid JSON file")
        }
        
    }
    
    //====================
    
    func setNotification(notiTitle:String, dateToFire:NSDate){
        
        let localNotification = UILocalNotification();
        localNotification.fireDate = dateToFire.dateByAddingTimeInterval(-900)
        localNotification.alertBody = "Event - \"\(notiTitle)\" starting in 15 minutes"
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.soundName = UILocalNotificationDefaultSoundName
        //        localNotification.timeZone = NSTimeZone(name: "UTC")
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
    }
    
    //====================
    
    func parseDateFromJSON(date:String) -> NSDate {
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFor.dateFromString(date)!
    }
    
    func getDateString(date:NSDate) -> String{
        let dateFor: NSDateFormatter = NSDateFormatter()
        dateFor.dateFormat = "h:mm a"
        return dateFor.stringFromDate(date)
    }
    
    func setNowEvent(timeLabel:UILabel?, detailLabel:UILabel?){
        
        timeLabel?.text = "N/A"
        detailLabel?.text = "No Event Available\n"
        
        for var jsonDateSch:JSON in jsonObj["open_house"].array!{
//            let now = parseDateFromJSON("2015-11-16T09:43:00+07:00")
            let now = NSDate()
            
            let date = jsonDateSch["date"].string
            
            print("Date 56643 : \(date)")
            
            let dateObj = parseDateFromJSON(date!)
            
            var timeText = "N/A"
            var detailText = "No Event Available\n"
            print("now \(now) compared to dateObj \(dateObj)")
            if(dateObj.isBeforeDate(now)){
                
                timeText = getDateString(parseDateFromJSON(jsonDateSch["schedule"][0]["time"].string!))
//                timeText = "wtf"
                detailText = jsonDateSch["schedule"][0]["title"].string!
                
                
                for var subjson:JSON in jsonDateSch["schedule"].array!{
                    let subdate = subjson["time"].string
                    
                    let subdateObj = parseDateFromJSON(subdate!)
//                    print("now \(now) compared to \(subdateObj)")
                    
                    if(subdateObj.isAfterDate(now)){
                        break
                    }
                    
                    if(subdateObj.isBeforeDate(now)){
                        timeText = getDateString(subdateObj)
                        detailText = subjson["title"].string!
                    }
                    
                }
                
                print("event time = \(timeText)\ndetail = \(detailText)")
                
                
               
                timeLabel?.text = timeText
                detailLabel?.text = detailText
                
                
                
            }
            
//            timeLabel?.text = timeText
//            detailLabel?.text = detailText
            
            
        }
    }
    
}

    
    