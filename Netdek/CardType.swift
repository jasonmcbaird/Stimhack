//
//  Type.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(CardType)
public class CardType: NSManagedObject {
    
    @NSManaged var card: Card
    @NSManaged var name: String
    @NSManaged var subtypes: NSSet
    
    func getTypeTraits() -> [String: AnyObject] {
        return Dictionary()
    }
    
    func setAllTraits(dictionary: [String: AnyObject]) {
        name = dictionary["type"] as! String
        if(dictionary["subtype"] != nil) {
            subtypes = NSSet(array: translateSubtypeString(dictionary["subtype"] as! String))
        } else {
            subtypes = NSSet(array: [])
        }
        setTypeTraits(dictionary)
    }
    
    func setTypeTraits(dictionary: [String: AnyObject]) {
        // This is an abstract function.
        // It's built to be overridden.
    }
    
    func translateSubtypeString(string: String) -> [String] {
        return string.componentsSeparatedByString(" - ")
    }
    
    func getTypeString() -> String {
        var array: [String] = []
        array.append("Type: \(name)")
        if(subtypes.count > 0) {
            var subtypeArray: [String] = []
            for subtype in subtypes {
                if(Array(subtypes.allObjects as! [String]).indexOf(subtype as! String) < subtypes.count - 1) {
                    subtypeArray.append("\(subtype as! String) - ")
                } else {
                    subtypeArray.append("\(subtype as! String)")
                }
            }
            array.append("Subtypes: " + subtypeArray.joinWithSeparator(""))
        }
        
        for key in getTypeTraits().keys {
            array.append("\(key): \(getTypeTraits()[key]!)")
        }
        
        var result = array.joinWithSeparator(", ")
        result = result + ", "
        return result
    }
    
    func getInt16Value(key: String, dictionary: [String: AnyObject]) -> Int16 {
        let int64Value = dictionary[key] as! Int
        return Int16(int64Value)
    }
    
}