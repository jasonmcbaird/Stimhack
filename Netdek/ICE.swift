//
//  Ice.swift
//  Netdek
//
//  Created by Jason Baird on 11/14/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(ICE)
public class ICE: CardType {
    
    @NSManaged var strength: Int16
    
    override func setTypeTraits(dictionary: [String: AnyObject]) {
        strength = getInt16Value("strength", dictionary: dictionary)
    }
    
    override func getTypeTraits() -> [String: AnyObject] {
        return ["Strength": Int(strength)]
    }
}