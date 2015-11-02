//
//  Bingo.swift
//  OpenHouseOneFive
//
//  Created by Bliss Wetchaye on 2015-10-19.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit
import SwiftyJSON

var NumColumns = 5
var NumRows = 5
class Bingo: NSObject {
    private var tiles = Array2D<Tile>(columns:NumColumns, rows: NumRows)
    
    func tileAtColumn(column: Int, row: Int) -> Tile? {
        return tiles[column, row]
    }
    
    init(random:Bool) {
        super.init()
        if(loadData()){
            return
        }else{
            let filename = "Level_5"
            if let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename) {
                //            if let columnN: AnyObject = dictionary["column"]{
                //                NumColumns = columnN.integerValue
                //            }
                //            if let rowN: AnyObject = dictionary["row"]{
                //                NumRows = rowN.integerValue
                //            }
                
                // The dictionary contains an array named "tiles". This array contains
                // one element for each row of the level. Each of those row elements in
                // turn is also an array describing the columns in that row. If a column
                // is 1, it means there is a tile at that location, 0 means there is not.
                let tileType = String(format: "type%i", Int(arc4random_uniform(3)) + 1)
                
                if let tilesArray: AnyObject = dictionary[tileType] {
                    
                    NumRows = tilesArray.count
                    NumColumns = tilesArray[0].count
                    
                    tiles = Array2D<Tile>(columns:NumColumns, rows: NumRows)
                    
                    // Loop through the rows...
                    for (row, rowArray) in (tilesArray as! [[Int]]).enumerate() {
                        
                        // Note: In Sprite Kit (0,0) is at the bottom of the screen,
                        // so we need to read this file upside down.
                        let tileRow = NumRows - row - 1
                        
                        // Loop through the columns in the current row...
                        for (column, rawValueIn) in rowArray.enumerate() {
                            tiles [column,tileRow] = Tile(column: column, row: tileRow,id:rawValueIn)
                        }
                    }
                }
            }
            
            if let path = NSBundle.mainBundle().pathForResource("faculty", ofType: "json"){
                do {
                    let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    let jsonObj = JSON(data: data)
                    if jsonObj != JSON.null {
                        
                        
                        for (key,subJson):(String, JSON) in jsonObj{
                            //Do something you want
                            
                            print("++\(subJson)")
                            
                            // Loop through the rows...
                            for row in 0..<NumRows {
                                for column in 0..<NumColumns {
                                    let tile = tiles [column,row]
                                    let a = subJson["เลข คณะ"].intValue
                                    print("\(tile!.id) \(a)")
                                    if(tile!.id == subJson["เลข คณะ"].intValue){
                                        tile!.thaiName = subJson["คณะ"].stringValue
                                        
                                        tile!.name = subJson["Faculty"].stringValue
                                        tile!.qr = subJson["QR Code"].stringValue
                                        tile!.color = UIColor(rgba: subJson["Color"].stringValue)
                                        print(tile!.name)
                                    }
                                }
                            }
                            
//                            print("jsonData:\(subJson)")
                            
                        }
                    } else {
                        print("invalid JSON file")
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else {
                print("Invaild filename/path!")
            }
        }
    }
    
    func gotTile(tile:Tile){
        tile.got = true
    }
    
    func gotTileWithQR(QR:String) -> Tile?{
        var tile:Tile?
        var correctile:Tile?
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                tile = tiles [column,row]
                
                if tile?.qr == QR {
                    gotTile(tile!)
                    correctile=tile
                }
            }
        }
        return correctile
    }
    
    func tileWithFaculty(fac:String) -> Tile?{
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let tile = tiles [column,row]
                
                if tile?.name == fac {

                    return tile
                }
            }
        }
        return nil
    }
    
    func tileWithID(inID:String) -> Tile?{
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let tile = tiles [column,row]
                print("\(tile!.id)")
                if "\(tile!.id)" == inID {
                    
                    return tile
                }
            }
        }
        return nil
    }
    
    func saveDataToUser(){
        var array = [Tile]()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let tile = tiles [column,row]
                array.append(tile!)
            }
        }
        
        // Archive it to NSData
        var data : NSData = NSKeyedArchiver.archivedDataWithRootObject(array)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "bingoArray")
        
        // Create a new object of Class B from the data
    }
    
    func loadData()->Bool{
//        return false
        if let data = NSUserDefaults.standardUserDefaults().dataForKey("bingoArray")
            
        {
            if let b2 : [Tile]? = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Tile]
            {
                for row in 0..<NumRows {
                    for column in 0..<NumColumns {
                        tiles [column,row] = b2?[row*5+column]
                    }
                }
                return true
            }
        }
        return false
    }
    
}
