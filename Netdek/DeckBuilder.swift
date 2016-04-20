//
//  DeckBuilder.swift
//  Netdek
//
//  Created by Jason Baird on 11/17/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
class DeckBuilder {
    
    static func createDeck(name: String, identity: Identity) -> Deck {
        let deck = CoreDataCreator.createObject("Deck") as! Deck
        deck.name = name
        deck.identity = identity
        deck.playsets = NSSet(array: Array<Playset>())
        CoreDataCreator.save()
        return deck
    }
}