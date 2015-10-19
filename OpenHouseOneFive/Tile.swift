//
//  Tile.swift
//  BlockThing
//
//  Created by Bliss Watchaye on 2015-10-13.
//  Copyright © 2015 confusians. All rights reserved.
//

import UIKit

class Tile : NSObject {
    var column: Int
    var row: Int
    
    var got : Bool
    
    var id:Int
    
    init(column: Int, row: Int,id:Int) {
        self.column = column
        self.row = row
        self.id = id
        got = false
        super.init()
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