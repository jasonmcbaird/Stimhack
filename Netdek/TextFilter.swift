//
//  TextFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class TextFilter: Filter {
    
    var text: String
    
    init(text: String) {
        self.text = text.lowercaseString
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        return card.rulesText.lowercaseString.containsString(text)
    }
}