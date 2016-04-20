//
//  FactionFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/24/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class FactionFilter: Filter {
    
    var faction: String
    
    init(faction: String) {
        self.faction = faction.lowercaseString
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        return card.faction.lowercaseString == faction
    }
}