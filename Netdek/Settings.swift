//
//  Settings.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(Settings)
class Settings: NSManagedObject {
    
    @NSManaged var cellImageBackgroundsEnabled: Bool
    @NSManaged var sets: NSSet
    @NSManaged var allSets: NSSet
    @NSManaged var coreSetCount: Int16
    
    func addSet(set: String) {
        var setArray = sets.allObjects as! [String]
        if(!setArray.contains(set)) {
            setArray.append(set)
            self.sets = NSSet(array: setArray)
            CoreDataCreator.save()
        }
    }
    
    func removeSet(set: String) {
        var setArray = sets.allObjects as! [String]
        if let index = setArray.indexOf(set) {
            setArray.removeAtIndex(index)
            self.sets = NSSet(array: setArray)
            CoreDataCreator.save()
        }
    }

    func getSets() -> [String] {
        return sets.allObjects as! [String]
    }
}