//
//  CardTypeBuilder.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class CardTypeBuilder {
    
    //static let cardTypeMap = ["CorpIdentity": CorpIdentity.self, "Operation": Operation.self]
    
    static func createCardType(card: Card, dictionary: [String: AnyObject]) -> CardType {
        var type: CardType
        let name = dictionary["type"] as! String
        if(name == "Identity") {
            if(card.side == "Runner") {
                type = CoreDataCreator.createObject("RunnerIdentity") as! CardType
            } else {
                type = CoreDataCreator.createObject("CorpIdentity") as! CardType
            }
        } else {
            type = CoreDataCreator.createObject(name) as! CardType
        }
        type.card = card
        type.setAllTraits(dictionary)
        return type
    }
}