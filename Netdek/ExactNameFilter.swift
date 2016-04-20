//
//  NameFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class ExactNameFilter: Filter {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        return name == card.name
    }
}