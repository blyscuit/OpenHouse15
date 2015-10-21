//
//  Tile.swift
//  BlockThing
//
//  Created by Bliss Watchaye on 2015-10-13.
//  Copyright © 2015 confusians. All rights reserved.
//

import UIKit

class Tile : NSObject,NSCoding {
    var column: Int
    var row: Int
    
    var got : Bool
    
    var id:Int
    var qr:String?
    var name:String?
    var thaiName:String?
    
    init(column: Int, row: Int,id:Int) {
        self.column = column
        self.row = row
        self.id = id
        got = false
        super.init()
    }

    //MARK: NSCoding
    
    required init(coder aDecoder: NSCoder) {
        self.got = aDecoder.decodeObjectForKey("got") as! Bool
        self.column = aDecoder.decodeObjectForKey("column") as! Int
        self.row = aDecoder.decodeObjectForKey("row") as! Int
        self.id = aDecoder.decodeObjectForKey("id") as! Int
        self.qr = aDecoder.decodeObjectForKey("qr") as! String
        self.thaiName = aDecoder.decodeObjectForKey("tname") as! String
        self.name = aDecoder.decodeObjectForKey("name") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(got, forKey: "got")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(column, forKey: "column")
        aCoder.encodeObject(row, forKey: "row")
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(thaiName, forKey: "tname")
        aCoder.encodeObject(qr, forKey: "qr")
    }
    
    //MARK: NSObjectProtocol
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Tile {
            return self.id == object.id &&
                self.name == object.name
        } else {
            return false
        }
    }
    
    override var hash: Int {
        return id.hashValue
    }
}

//enum TileType: Int, CustomStringConvertible {
//    //0,1Ground , 2Lava,3Wall, 4Monster, 5Button, 6Birth, 7Key, 8Lock,9door,10 second birth,11CircleMon"
//    case Unknown = 0,Ground , Lava,Wall, Monster, Button, Birth, Key, Lock,Door,Second,CircleMon
//    
//    static func random() -> TileType {
//        return TileType(rawValue: Int(arc4random_uniform(6)) + 1)!
//    }
//}