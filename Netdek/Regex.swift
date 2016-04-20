//
//  Regex.swift
//  Netdek
//
//  Created by Jason Baird on 11/18/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class Regex {
    
    static func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matchesInString(text,
                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}