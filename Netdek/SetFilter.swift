//
//  SetFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/23/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class SetFilter: Filter {
    
    var sets: [String]
    
    init(set: String) {
        self.sets = [set]
    }
    
    init(sets: [String]) {
        self.sets = sets
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        return sets.contains(card.set)
    }
}