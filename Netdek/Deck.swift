//
//  Deck.swift
//  Netdek
//
//  Created by Jason Baird on 11/16/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(Deck)
class Deck: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var identity: Identity
    @NSManaged var playsets: NSSet
    
    func getSide() -> String {
        return identity.card.side
    }
    
    func getFaction() -> String {
        return identity.card.faction
    }
    
    func isLegal() -> Bool {
        return isSizeLegal() && isInfluenceLegal()
    }
    
    func isSizeLegal() -> Bool {
        return getCardCount() >= Int(identity.deckSize)
    }
    
    func isInfluenceLegal() -> Bool {
        return getInfluenceCount() <= Int(identity.influencePoints)
    }
    
    func getCardCount() -> Int {
        var count = 0
        for playset in playsets {
            count += playset.count
        }
        return count
    }
    
    func getInfluenceCount() -> Int {
        return getInfluenceCount(playsets.allObjects as! [Playset], faction: identity.card.faction)
    }
    
    func getInfluenceCount(playsets: [Playset], faction: String) -> Int {
        // TODO: Account for Alliance cards. Check for other similar Influence-modifying cards.
        var influence = 0
        for playset in playsets {
            if(playset.card.faction != faction) {
                if(playset.card.influenceCost != -1) {
                    influence = influence + (Int(playset.card.influenceCost) * Int(playset.count))
                }
            }
        }
        return influence
    }
    
    func getCards() -> [Card] {
        var cards: [Card] = []
        for playset in playsets.allObjects as! [Playset] {
            cards.append(playset.card)
        }
        return cards
    }
    
    func getPlayset(card: Card) -> Playset? {
        for playset in playsets.allObjects as! [Playset] {
            if(playset.card == card) {
                return playset
            }
        }
        return nil
    }
    
    func addCard(card: Card) {
        if(getCards().contains(card)) {
            let playset = getPlayset(card)!
            playset.count++
            if(Int(playset.count) > card.getMaxDeckCount()) {
                playset.count = Int16(card.getMaxDeckCount())
            }
        } else {
            addCardAndPlayset(card)
        }
        CoreDataCreator.save()
        notify()
    }
    
    func addCardAndPlayset(card: Card) {
        let playset = CoreDataCreator.createObject("Playset") as! Playset
        playset.card = card
        playset.count = 1
        playset.deck = self
        var playsetArray = playsets.allObjects as! [Playset]
        playsetArray.append(playset)
        playsets = NSSet(array: playsetArray)
    }
    
    func removeCard(card: Card) {
        if(getCards().contains(card)) {
            let playset = getPlayset(card)!
            if(playset.count <= 1) {
                removePlayset(playset)
            } else {
                playset.count--
            }
            CoreDataCreator.save()
            notify()
        }
    }
    
    func removePlayset(playset: Playset) {
        var playsetArray = playsets.allObjects as! [Playset]
        playsetArray.removeAtIndex(playsetArray.indexOf(playset)!)
        playsets = NSSet(array: playsetArray)
    }
    
    func printDecklist() {
        print("Decklist for \(name):")
        for playset in playsets.allObjects as! [Playset] {
            print("\(playset.card.name) x\(playset.count)")
        }
    }
    
    func notify() {
        NSNotificationCenter.defaultCenter().postNotificationName("DeckChanged", object: self)
    }
    
}