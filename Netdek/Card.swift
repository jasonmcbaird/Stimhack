//
//  Card.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Card)
public class Card: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var side: String
    @NSManaged var type: CardType
    @NSManaged var faction: String
    @NSManaged var cost: Int16
    @NSManaged var influenceCost: Int16
    @NSManaged var rulesText: String
    @NSManaged var flavorText: String
    @NSManaged var set: String
    @NSManaged var image: String
    
    // Sort order:
    // Faction
    // Card Type Sort
    // Cost
    
    func getCardString() -> String {
        var array: [String] = []
        array.append("Name: \(name)")
        array.append("Side: \(side)")
        array.append("Faction: \(faction)")
        array.append("Cost: \(cost)")
        array.append("Influence Cost: \(influenceCost)")
        array.append("Rules Text: \(rulesText)")
        array.append("Flavor Text: \(flavorText)")
        
        var result = array.joinWithSeparator(", ")
        result = result + ", "
        result = result + type.getTypeString()
        result = result + "Set: \(set), "
        result = result + "Image: \(image)"
        return result
    }
    
    func getImage() -> UIImage? {
        if(image != "") {
            let rootPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let path = "\(rootPath)/\(image)"
            let uiImage = UIImage(contentsOfFile: path)
            if(uiImage != nil) {
                return uiImage
            } else {
                print("Could not load card image: \(path)")
                return nil
            }
        }
        return nil
    }
    
    func getMaxDeckCount() -> Int {
        let match2 = Regex.matchesForRegexInText("Limit \\d+ per deck.", text: rulesText)
        var result: Int = 3
        if(match2.count > 0) {
            let index = match2[0].startIndex.advancedBy(6)
            let int = Int(String(match2[0][index]))!
            if(int < result) {
                result = int
            }
        }
        let cardsOwned = CardOwnedCounter.getCardOwnedCount(self)
        if(cardsOwned < result) {
            result = cardsOwned
        }
        return result
    }
    
}