//
//  RunnerIdentity.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(RunnerIdentity)
public class RunnerIdentity: Identity {
    
    @NSManaged var linkStrength: Int16
    
    override func setTypeTraits(dictionary: [String: AnyObject]) {
        super.setTypeTraits(dictionary)
        linkStrength = getInt16Value("baselink", dictionary: dictionary)
    }
    
    override func getTypeTraits() -> [String: AnyObject] {
        return ["Minimum Deck Size": Int(deckSize), "Influence Points": Int(influencePoints), "Link Strength": Int(linkStrength)]
    }
    
    // Sort order:
    // Deck size
    // Influence points
    
}