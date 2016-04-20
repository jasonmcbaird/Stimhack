//
//  DeckSorter.swift
//  Netdek
//
//  Created by Jason Baird on 11/24/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class DeckSorter {
    
    static func complexSort(decks: [Deck]) -> [Deck] {
        let sorted = decks.sort({ (lhs: Deck, rhs: Deck) -> Bool in
            if(lhs.identity.card.side == rhs.identity.card.side) {
                if(lhs.identity.card.faction == rhs.identity.card.faction) {
                    if(lhs.name == rhs.name) {
                        return lhs.identity.card.name < rhs.identity.card.name
                    } else {
                        return lhs.name < rhs.name
                    }
                } else {
                    return lhs.identity.card.faction < rhs.identity.card.faction
                }
            } else {
                return lhs.identity.card.side > rhs.identity.card.side
            }
        })
        return sorted
    }
}