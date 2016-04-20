//
//  ArrayManager.swift
//  Netdek
//
//  Created by Jason Baird on 11/21/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class ArrayUtility {
    
    static func uniq<S : SequenceType, T : Hashable where S.Generator.Element == T>(source: S) -> [T] {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
}