//
//  NameFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class NameFilter: Filter {
    
    var name: String
    
    init(name: String) {
        self.name = name.lowercaseString
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        return card.name.lowercaseString.containsString(name)
    }
}