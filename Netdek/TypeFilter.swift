//
//  TypeFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class TypeFilter: Filter {
    
    var types: [String]
    
    init(type: String) {
        self.types = [type]
    }
    
    init(types: [String]) {
        self.types = types
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        if(types.contains("Icebreaker") && (card.type.subtypes.allObjects as! [String]).contains("Icebreaker")) {
            return true
        }
        if(types.contains("Program") && (card.type.subtypes.allObjects as! [String]).contains("Icebreaker")) {
            var otherTypes = types
            otherTypes.removeAtIndex(types.indexOf("Program")!)
            return otherTypes.contains(card.type.name)
        }
        return types.contains(card.type.name)
    }
}