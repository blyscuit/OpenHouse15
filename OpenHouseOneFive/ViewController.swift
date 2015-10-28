//
//  ViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Watchaye on 2015-10-12.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,BingoViewControllerDelegate{
    
    @IBOutlet weak var tableMain: UITableView!
    
    @IBOutlet weak var qrInstructionLabel: UILabel!
    
    var facultyArray:[Tile]!
    var facultyVisitArray:[Tile]!
    
    
    var bingoCell:BingoViewController!
    
    let titleText = ["NOW EVENT","CHECK IN","Visited faculties","Locked faculties - Please check in to unlock "]
    let titleImage = ["now-event-icon.png","check-in-icon.png"]
    
    var bingoBoard:Bingo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableMain.delegate = self
        tableMain.dataSource = self
        
        bingoBoard = Bingo(random: true)
        genFacArray()
//        bingoTable.frame.size = CGSizeMake(bingoTable.frame.size.width, bingoTable.frame.size.width)
        
//        bingoTable.reloadData()
    }
    
    func genFacArray(){
        facultyArray = [Tile]()
        facultyVisitArray = [Tile]()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let tile = bingoBoard.tileAtColumn(column, row: row){
                    if((tile.got) == true){
                        facultyVisitArray.append(tile)
                    }else{
                        facultyArray.append(tile)
                    }
                }
            }
        }
//        bingoBoard.gotTile(bingoBoard.tileAtColumn(0, row: 4)!)
        bingoBoard.saveDataToUser()

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
            
            let mess:String?
            
            if let tile = self.bingoBoard.gotTileWithQR(result){
                 mess = "\(tile.name!) \(tile.thaiName)"
            }else{
                mess = "Incorrect QR code"
            }
            
            let alert = UIAlertController(title: "Faculty unlock", message: result, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
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
            //            let user = self.sections[indexPath.section].users[indexPath.row]
            if(indexPath.section==0){
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
            
            cell.detailTextLabel?.text = "Tile"
            cell.textLabel?.text = "Time am"
            
            return cell
            }else if(indexPath.section==1){
                var cell = tableView.dequeueReusableCellWithIdentifier("bingoCell", forIndexPath: indexPath) as! BingoViewController
                cell.bingoBoard = self.bingoBoard
                bingoCell = cell
                cell.delegate = self
                cell.start()
                return cell
            }else{
                var cell = tableView.dequeueReusableCellWithIdentifier("facultyStatusCell", forIndexPath: indexPath) as! TitleTableViewCell
                let tile:Tile!
                if(indexPath.section == 2){
                    tile = facultyVisitArray[indexPath.row]
                }else{
                    tile = facultyArray[indexPath.row]
                }
                cell.titleLabel.text = tile.thaiName
                cell.subTitleLabel.text = tile.name
                cell.imageView?.image = UIImage(named: "\(tile.id)")
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
                            length: 29))
                } else {
                    // Fallback on earlier versions
                }
                myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(16, 29))
                headerCell?.titleLabel.attributedText = myMutableString
            }else{
                headerCell?.titleLabel?.text = titleText[section]
            }
            
            return headerCell
        }
    }
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(indexPath.section == 1){
            return false
        }
        return true
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 22;
        }else if(indexPath.section==1){
            return self.view.frame.size.width + 150;
        }else{
            return 58
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    
    // MARK: - bingo view data source
    func bingoControllerDidCheckIn(controller: BingoViewController) {
        self.scanAction(self)
    }
    func bingoControllerDidTapCell(controller: BingoViewController) {
        
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        tableMain.reloadData()
    }
}

    
    