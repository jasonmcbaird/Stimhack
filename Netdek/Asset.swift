//
//  Asset.swift
//  Netdek
//
//  Created by Jason Baird on 11/14/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(Asset)
public class Asset: CardType {
    
    @NSManaged var trashCost: Int16
    
    override func setTypeTraits(dictionary: [String: AnyObject]) {
        trashCost = getInt16Value("trash", dictionary: dictionary)
    }
    
    override func getTypeTraits() -> [String: AnyObject] {
        return ["Trash Cost": Int(trashCost)]
    }
}