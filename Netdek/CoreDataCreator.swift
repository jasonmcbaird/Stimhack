//
//  CoreDataBuilder.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataCreator {
    
    static let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
    static let managedContext = appDelegate.managedObjectContext
    
    static func createObject(key: String) -> NSManagedObject {
        let object = NSEntityDescription.insertNewObjectForEntityForName(key, inManagedObjectContext: managedContext)
        return object
    }
    
    static func save() {
        var error: NSError?
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error?.userInfo)")
        }
    }
}