//
//  Icebreaker.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(Program)
public class Program: CardType {
    
    @NSManaged var memoryCost: Int16
    @NSManaged var strength: Int16
    
    override func setTypeTraits(dictionary: [String: AnyObject]) {
        if(dictionary["memoryunits"] != nil) {
            memoryCost = getInt16Value("memoryunits", dictionary: dictionary)
        } else {
            memoryCost = -1
        }
        if(dictionary["strength"] != nil) {
            strength = getInt16Value("strength", dictionary: dictionary)
        } else {
            strength = -1
        }
    }
    
    override func getTypeTraits() -> [String: AnyObject] {
        return ["Memory Cost": Int(memoryCost), "Strength": Int(strength)]
    }
    
    // Sort order:
    // Two icebreaker types - Fracter - Decoder - Killer - Icebreaker - none of the above
    
}