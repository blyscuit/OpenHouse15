//
//  Extensions.swift
//  CookieCrunch
//
//  Created by Matthijs on 19-06-14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation

extension Dictionary {

  // Loads a JSON file from the app bundle into a new dictionary
  static func loadJSONFromBundle(filename: String) -> Dictionary<String, AnyObject>? {
    if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {

      var error: NSError?
      let data: NSData?
      do {
        data = try NSData(contentsOfFile: path, options: NSDataReadingOptions())
      } catch let error1 as NSError {
        error = error1
        data = nil
      }
      if let data = data {

        let dictionary: AnyObject?
        do {
          dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
        } catch let error1 as NSError {
          error = error1
          dictionary = nil
        }
        if let dictionary = dictionary as? Dictionary<String, AnyObject> {
          return dictionary
        } else {
          print("Level file '\(filename)' is not valid JSON: \(error!)")
          return nil
        }
      } else {
        print("Could not load level file: \(filename), error: \(error!)")
        return nil
      }
    } else {
      print("Could not find level file: \(filename)")
      return nil
    }
  }
}

// MARK: - UIColor Extension
import UIKit
func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
}
extension UIColor {

    static func randomColor() -> UIColor {
        let r = randomCGFloat()
        let g = randomCGFloat()
        let b = randomCGFloat()
        
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    public convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.startIndex.advancedBy(1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
