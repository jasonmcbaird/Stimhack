//
//  InfluenceFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/23/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class InfluenceFilter: Filter {
    
    var influence: Int
    
    init(influence: Int) {
        self.influence = influence
    }
    
    func cardMatchesFilter(card: Card) -> Bool {
        return self.influence == Int(card.influenceCost)
    }
}