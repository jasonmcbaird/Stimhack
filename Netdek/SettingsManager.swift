//
//  SettingsManager.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class SettingsManager {
    
    static var settings: Settings? = nil
    
    static func cellImageBackgroundsEnabled() -> Bool {
        loadSettings()
        return settings!.cellImageBackgroundsEnabled
    }
    
    static func loadSettings() -> Settings {
        if(settings == nil) {
            settings = CoreDataLoader.loadFirstObject("Settings") as? Settings
            if(settings == nil) {
                settings = (CoreDataCreator.createObject("Settings") as! Settings)
                settings!.cellImageBackgroundsEnabled = false
                settings!.allSets = NSSet(array: getAllSets())
                settings!.sets = settings!.allSets
                settings!.coreSetCount = Int16(3)
            }
        }
        return settings!
    }
    
    static func getAllSets() -> [String] {
        var sets: [String] = []
        let cards = CoreDataLoader.getAllCards()
        for card in cards {
            if(!sets.contains(card.set)) {
                sets.append(card.set)
            }
        }
        return sets
    }
    
}