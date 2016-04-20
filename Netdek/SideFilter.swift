//
//  SideFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class SideFilter: Filter {
    
    var side: String
    
    init(side: String) {
        self.side = side
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        return card.side == side
    }
}