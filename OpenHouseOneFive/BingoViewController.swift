//
//  BingoViewController.swift
//  Pods
//
//  Created by Bliss Watchaye on 2015-10-21.
//
//

import UIKit
@objc protocol BingoViewControllerDelegate {
    func bingoControllerDidCheckIn(controller: BingoViewController)
    func bingoControllerDidTapCell(controller: BingoViewController)
}
class BingoViewController: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var qrInstructionLabel: UILabel!
    @IBOutlet weak var bingoCOllection: UICollectionView!
    @IBOutlet weak var gridOverlay: UIImageView!
    
    var bingoBoard:Bingo!
    
    var delegate: BingoViewControllerDelegate?
    @IBAction func checkInPress(sender: AnyObject) {
        delegate?.bingoControllerDidCheckIn(self)
    }
    func start() {
        bingoCOllection.delegate = self
        bingoCOllection.dataSource = self
        
        setQRText()
        
        self.gridOverlay.frame = bingoCOllection.frame
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (self.frame.size.width-60)/5, height:(self.frame.size.width-60)/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        bingoCOllection.collectionViewLayout = layout
        
        //force collection view to reload on main thread
        dispatch_async(dispatch_get_main_queue()) {
            self.bingoCOllection.reloadData()
        }
        
        self.gridOverlay.frame = bingoCOllection.frame
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

    
//    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: (self.frame.size.width-60)/5, height:(self.frame.size.width-60)/5)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        bingoCOllection.collectionViewLayout = layout
//        
//        bingoCOllection.reloadData()
//    }
    // MARK: - collection view data source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumColumns*NumRows
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("stamp", forIndexPath: indexPath) as! BingoCollectionViewCell
            let column = indexPath.row % 5
            var row = indexPath.row / 5
            row = 4 - row
            //cell.facultyImage.backgroundColor = bingoBoard.tileAtColumn(column, row: row)?.color
            //print(cell.facultyImage.backgroundColor)
            
            var imageName=""
            if((bingoBoard.tileAtColumn(column, row: row)?.got) == true){
                imageName = "active_\(bingoBoard.tileAtColumn(column, row: row)!.id)"
            }else{
                imageName = "inactive_\(bingoBoard.tileAtColumn(column, row: row)!.id)"
            }
            print(imageName)
            cell.facultyImage.image = UIImage(named: imageName)
            cell.facultyImage.contentMode = UIViewContentMode.ScaleAspectFit
            
            //             Customize cell height
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y,collectionView.frame.size.width/5, collectionView.frame.size.height/5)
            return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (self.frame.size.width-60)/5, height:(self.frame.size.width-60)/5)
    }
    func collectionView(collectionView: UICollectionView,
        shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        print((collectionView.cellForItemAtIndexPath(indexPath) as! BingoCollectionViewCell).facultyImage.backgroundColor)
    }
}
