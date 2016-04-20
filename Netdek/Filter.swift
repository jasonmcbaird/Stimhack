//
//  Filter.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

protocol Filter {
    
    func cardMatchesFilter(card: Card) -> Bool
    
}