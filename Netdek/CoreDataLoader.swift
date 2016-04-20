//
//  CoreDataLoader.swift
//  Netdek
//
//  Created by Jason Baird on 11/15/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataLoader {
    
    static let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
    static let managedContext = appDelegate.managedObjectContext
    static var cards: [Card] = []
    
    static func getCardByName(name: String) -> Card? {
        let cards = getAllCards()
        for card in cards {
            if(card.name == name) {
                return card
            }
        }
        return nil
    }
    
    static func getAllRunnerCards() -> [Card] {
        return CardFilterer.filter(getAllCards(), filters: [SideFilter(side: "Runner")])
    }
    
    static func getAllCorpCards() -> [Card] {
        return CardFilterer.filter(getAllCards(), filters: [SideFilter(side: "Corp")])
    }
    
    static func getAllCards() -> [Card] {
        if(cards.count <= 0) {
            let cards = loadObjects("Card") as! [Card]
            return smartSort(cards)
        } else {
            return cards
        }
    }
    
    static func smartSort(cards: [Card]) -> [Card] {
        return cards.sort{ $0.side != $1.side ? $0.side < $1.side : $0.type.name < $1.type.name }
    }
    
    static func loadObjects(entityName: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        fetchRequest.includesSubentities = true
        var fetchedResults: [NSManagedObject]? = []
        do {
            fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        } catch _ {
            print("Failed to fetch NSManagedData")
        }
        if let results = fetchedResults {
            return results
        }
        return []
    }
    
    static func loadFirstObject(entityName: String) -> NSManagedObject? {
        let array = loadObjects(entityName)
        if(array.count > 0) {
            return array[0]
        } else {
            return nil
        }
    }
    
    static func deleteCard(card: Card) {
        managedContext.deleteObject(card)
    }
    
    static func getDecks() -> [Deck] {
        let decks = loadObjects("Deck") as! [Deck]
        return decks
    }
    
}