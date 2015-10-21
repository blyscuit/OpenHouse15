//
//  ViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Watchaye on 2015-10-12.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var tableMain: UITableView!
    @IBOutlet weak var bingoTable: UICollectionView!
    
    @IBOutlet weak var qrInstructionLabel: UILabel!
    let titleText = ["NOW EVENT","CHECK IN"]
    let titleImage = ["now-event-icon.png","check-in-icon.png"]
    
    var bingoBoard:Bingo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableMain.delegate = self
        tableMain.dataSource = self
        
        bingoTable.delegate = self
        bingoTable.dataSource = self
        bingoBoard = Bingo(filename: "Level_5")
//        bingoTable.frame.size = CGSizeMake(bingoTable.frame.size.width, bingoTable.frame.size.width)
        
//        bingoTable.reloadData()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (self.view.frame.size.width-60)/5, height:(self.view.frame.size.width-60)/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        bingoTable.collectionViewLayout = layout
        
        setQRText()
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (self.view.frame.size.width-60)/5, height:(self.view.frame.size.width-60)/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        bingoTable.collectionViewLayout = layout
        
        bingoTable.reloadData()
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
            let alert = UIAlertController(title: "QRCodeReader", message: result, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            })
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView)
        -> Int {
            return 2;
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            if(section == 0){
                return 1
            }
            return 0
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            //            let user = self.sections[indexPath.section].users[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
            
            cell.detailTextLabel?.text = "Tile"
            cell.textLabel?.text = "Time am"
            
            return cell
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
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("cellHeader") as? TitleTableViewCell
        headerCell?.titleLabel?.text = titleText[section]
        headerCell?.titleImage.image = UIImage(named: titleImage[section])
        return headerCell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 22;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    // MARK: - collection view data source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5*5
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("stamp", forIndexPath: indexPath) as! BingoCollectionViewCell
            cell.facultyImage.backgroundColor = UIColor.randomColor()
            
//             Customize cell height
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y,collectionView.frame.size.width/5, collectionView.frame.size.height/5)
            return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width-60)/5, height:(self.view.frame.size.width-60)/5)
    }
    func collectionView(collectionView: UICollectionView,
        shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        print((collectionView.cellForItemAtIndexPath(indexPath) as! BingoCollectionViewCell).facultyImage.backgroundColor)
    }
    
    func setQRText(){
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "Explore more faculty and scan QR Code to unlock a prize.")
        // NSMutableAttributedString(
            //string: "Explore more faculty and scan QR Code to unlock a prize.",
            //attributes: [NSFontAttributeName:UIFont(
            //    name: "Georgia",
            //    size: 18.0)!])
        //Add more attributes here
        
            myMutableString.addAttribute(NSFontAttributeName,
                value: UIFont.boldSystemFontOfSize(13),
                range: NSRange(
                    location: 25,
                    length: 12))
        
        //Apply to the label
        qrInstructionLabel.attributedText = myMutableString
    }
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//            return CGSizeMake(collectionView.bounds.size.width/6, collectionView.bounds.size.height/6)
//    }
}

    
    