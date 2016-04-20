//
//  Playset.swift
//  Netdek
//
//  Created by Jason Baird on 11/18/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(Playset)
class Playset: NSManagedObject {
    
    @NSManaged var card: Card
    @NSManaged var count: Int16
    @NSManaged var deck: Deck
    
}