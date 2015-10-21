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
    
    init(filename: String) {
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
            if let tilesArray: AnyObject = dictionary["tiles"] {
                
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
                    
                    // Loop through the rows...
                    for (key,subJson):(String, JSON) in jsonObj["fac"] {
                        //Do something you want
                        
                        print("jsonData:\(subJson)")
                        for row in 0..<NumRows {
                            for column in 0..<NumColumns {
                                tiles [column,row]?.id =
                            }
                        }
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
