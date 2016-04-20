//
//  Identity.swift
//  Netdek
//
//  Created by Jason Baird on 11/16/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(Identity)
public class Identity: CardType {
    
    @NSManaged var deckSize: Int16
    @NSManaged var influencePoints: Int16
    
    override func setTypeTraits(dictionary: [String: AnyObject]) {
        deckSize = getInt16Value("minimumdecksize", dictionary: dictionary)
        if(dictionary["influencelimit"] != nil) {
            influencePoints = getInt16Value("influencelimit", dictionary: dictionary)
        } else {
            influencePoints = -1
        }
    }
    
    override func getTypeTraits() -> [String: AnyObject] {
        return ["Minimum Deck Size": Int(deckSize), "Influence Points": Int(influencePoints)]
    }
    
    // Sort order:
    // Deck size
    // Influence points
    
}