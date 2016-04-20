//
//  CardSorter.swift
//  Netdek
//
//  Created by Jason Baird on 11/21/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class CardSorter {
    
    static var icebreakerSubtypes: [String] = ["Fracter", "Decoder", "Killer", "AI"]
    static var iceSubtypes: [String] = ["Barrier", "Code Gate", "Sentry", "Mythic", "Trap"]
    static var cardTypes: [String] = ["Agenda", "ICE", "Asset", "Upgrade", "Operation", "Program", "Hardware", "Resource", "Event", "Identity"]
    
    static func complexSort(playsets: [Playset]) -> [Playset] {
        var cards: [Card] = []
        for playset in playsets {
            cards.append(playset.card)
        }
        cards = complexSort(cards)
        var result: [Playset] = []
        for card in cards {
            result.append(getPlayset(card, playsets: playsets)!)
        }
        return result
    }
    
    static func getPlayset(card: Card, playsets: [Playset]) -> Playset? {
        for playset in playsets {
            if(playset.card == card) {
                return playset
            }
        }
        return nil
    }
    
    static func complexSort(cards: [Card]) -> [Card] {
        let sorted = cards.sort({ (lhs: Card, rhs: Card) -> Bool in
            let greaterTypeComparison = getTypeComparison(lhs, rhs: rhs)
            if greaterTypeComparison == 0 {
                if(lhs.cost == rhs.cost) {
                    if(lhs.faction == rhs.faction) {
                        return lhs.name < rhs.name
                    } else {
                        return lhs.faction < rhs.faction
                    }
                } else {
                    return lhs.cost < rhs.cost
                }
            } else {
                return greaterTypeComparison > 0
            }
        })
        return sorted
    }
    
    static func getTypeComparison(lhs: Card, rhs: Card) -> Int {
        if(lhs.type.name == "Program" && rhs.type.name == "Program") {
            if(lhs.type.subtypes.containsObject("Icebreaker") && !rhs.type.subtypes.containsObject("Icebreaker")) {
                return 1
            }
            if(!lhs.type.subtypes.containsObject("Icebreaker") && rhs.type.subtypes.containsObject("Icebreaker")) {
                return -1
            }
            if(lhs.type.subtypes.containsObject("Icebreaker") && rhs.type.subtypes.containsObject("Icebreaker")) {
                for subtype in icebreakerSubtypes {
                    if(lhs.type.subtypes.containsObject(subtype) && !rhs.type.subtypes.containsObject(subtype)) {
                        return 1
                    }
                    if(!lhs.type.subtypes.containsObject(subtype) && rhs.type.subtypes.containsObject(subtype)) {
                        return -1
                    }
                }
                return 0
            }
            return 0
        }
        if(lhs.type.name == "ICE" && rhs.type.name == "ICE") {
            for subtype in iceSubtypes {
                if(lhs.type.subtypes.containsObject(subtype) && !rhs.type.subtypes.containsObject(subtype)) {
                    return 1
                }
                if(!lhs.type.subtypes.containsObject(subtype) && rhs.type.subtypes.containsObject(subtype)) {
                    return -1
                }
            }
        }
        // TODO: Specific order, not alphabetical
        if(cardTypes.indexOf(lhs.type.name) == cardTypes.indexOf(rhs.type.name)) {
            return 0
        }
        if(cardTypes.indexOf(lhs.type.name) < cardTypes.indexOf(rhs.type.name)) {
            return 1
        }
        if(cardTypes.indexOf(lhs.type.name) > cardTypes.indexOf(rhs.type.name)) {
            return -1
        }
        return 0
    }
}