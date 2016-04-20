//
//  CardBuilder.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class CardBuilder {
    
    static func createAllCardsFromAPI(string: String) -> [Card] {
        let cardDictionaries = APITranslator.translateFullAPI(string)
        var results: [Card] = []
        for dictionary in cardDictionaries {
            if(dictionary["setname"] as! String != "Draft") {
                results.append(translateCard(dictionary))
            }
        }
        return results
    }
    
    static func translateCard(dictionary: [String: AnyObject]) -> Card {
        let card = CoreDataCreator.createObject("Card") as! Card
        setCardGuaranteedValues(card, dictionary: dictionary)
        setCardOptionalValues(card, dictionary: dictionary)
        card.type = CardTypeBuilder.createCardType(card, dictionary: dictionary)
        return card
    }
    
    static func setCardGuaranteedValues(card: Card, dictionary: [String: AnyObject]) {
        card.name = dictionary["title"] as! String
        card.side = dictionary["side"] as! String
        card.faction = (dictionary["faction_code"] as! String).capitalizedString
        let imageStringArray = (dictionary["imagesrc"] as! String).componentsSeparatedByString("/")
        card.image = imageStringArray[imageStringArray.count - 1]
    }
    
    static func setCardOptionalValues(card: Card, dictionary: [String: AnyObject]) {
        setCardCost(card, dictionary: dictionary)
        setCardInfluenceCost(card, dictionary: dictionary)
        setCardRulesText(card, dictionary: dictionary)
        setCardFlavorText(card, dictionary: dictionary)
        setCardSet(card, dictionary: dictionary)
    }
    
    static func setCardCost(card: Card, dictionary: [String: AnyObject]) {
        var cost: Int = -1
        let costKeyStrings = ["advancementcost", "cost"]
        for keyString in costKeyStrings {
            if(dictionary[keyString] != nil) {
                if let costString = dictionary[keyString] as? String {
                    print("Cost of \(card.name) is '\(costString)'. Faction is '\(card.faction)'.")
                }
                cost = dictionary[keyString] as! Int
            }
        }
        card.cost = Int16(cost)
    }
    
    static func setCardInfluenceCost(card: Card, dictionary: [String: AnyObject]) {
        if(dictionary["factioncost"] as? Int != nil) {
            card.influenceCost = Int16(dictionary["factioncost"] as! Int)
        } else {
            card.influenceCost = -1
        }
    }
    
    static func setCardRulesText(card: Card, dictionary: [String: AnyObject]) {
        if(dictionary["text"] as? String != nil) {
            card.rulesText = dictionary["text"] as! String
        } else {
            card.rulesText = ""
        }
    }
    
    static func setCardFlavorText(card: Card, dictionary: [String: AnyObject]) {
        if(dictionary["flavor"] as? String != nil) {
            card.flavorText = dictionary["flavor"] as! String
        } else {
            card.flavorText = ""
        }
    }
    
    static func setCardSet(card: Card, dictionary: [String: AnyObject]) {
        var set: String = ""
        let setKeyStrings = ["set_code", "setname"]
        for keyString in setKeyStrings {
            if(dictionary[keyString] != nil) {
                set = (dictionary[keyString] as! String).capitalizedString
            }
        }
        card.set = set
    }
    
    static func translateCard(string: String) -> Card {
        return translateCard(APITranslator.translateAPIObjectToDictionary(string))
    }
}