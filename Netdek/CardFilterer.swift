//
//  CardFilter.swift
//  Netdek
//
//  Created by Jason Baird on 11/16/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class CardFilterer {
    
    static func filter(cards: [Card], filters: [Filter]) -> [Card] {
        var results: [Card] = []
        for card in cards {
            var legal = true
            for filter in filters {
                if(!filter.cardMatchesFilter(card)) {
                    legal = false
                }
            }
            if(legal) {
                results.append(card)
            }
        }
        return results
    }
    
    static func filter(cards: [Card], filters: [Filter], oppositeFilters: [Filter]) -> [Card] {
        var results: [Card] = []
        for card in cards {
            var legal = true
            for filter in filters {
                if(!filter.cardMatchesFilter(card)) {
                    legal = false
                }
            }
            for filter in oppositeFilters {
                if(filter.cardMatchesFilter(card)) {
                    legal = false
                }
            }
            if(legal) {
                results.append(card)
            }
        }
        return results
    }
}