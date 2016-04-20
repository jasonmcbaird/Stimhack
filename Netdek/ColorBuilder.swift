//
//  FactionColorBuilder.swift
//  Netdek
//
//  Created by Jason Baird on 11/16/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class ColorBuilder {
    
    static var colorDictionary: [String: UIColor] = Dictionary()
    static var darkColorDictionary: [String: UIColor] = Dictionary()
    
    static func setupColorDictionary() {
        colorDictionary = ["Anarch": getRGBColor(237, green: 211, blue: 191), "Criminal": getRGBColor(198, green: 211, blue: 221), "Shaper": getRGBColor(212, green: 222, blue: 197), "Haas-Bioroid": getRGBColor(218, green: 211, blue: 224), "Jinteki": getRGBColor(232, green: 216, blue: 207), "Nbn": getRGBColor(244, green: 224, blue: 188), "Weyland-Consortium": getRGBColor(219, green: 228, blue: 219), "Neutral": getRGBColor(232, green: 236, blue: 238), "Adam": getRGBColor(238, green: 235, blue: 227), "Apex": getRGBColor(218, green: 215, blue: 214), "Sunny-Lebeau": getRGBColor(236, green: 234, blue: 232)]
        darkColorDictionary = ["Anarch": getRGBColor(120, green: 76, blue: 51), "Criminal": getRGBColor(55, green: 65, blue: 70), "Shaper": getRGBColor(81, green: 113, blue: 67), "Haas-Bioroid": getRGBColor(82, green: 62, blue: 89), "Jinteki": getRGBColor(115, green: 51, blue: 37), "Nbn": getRGBColor(210, green: 162, blue: 51), "Weyland-Consortium": getRGBColor(112, green: 119, blue: 112), "Neutral": getRGBColor(116, green: 137, blue: 146), "Adam": getRGBColor(92, green: 85, blue: 66), "Apex": getRGBColor(94, green: 42, blue: 42), "Sunny-Lebeau": getRGBColor(68, green: 68, blue: 68)]
    }
    
    static func getRGBColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func getFactionColor(faction: String) -> UIColor? {
        if(colorDictionary.count <= 0) {
            setupColorDictionary()
        }
        if(colorDictionary[faction] == nil) {
            print("Could not find color for \(faction)")
        }
        return colorDictionary[faction]
    }
    
    static func getDarkFactionColor(faction: String) -> UIColor? {
        if(colorDictionary.count <= 0) {
            setupColorDictionary()
        }
        if(darkColorDictionary[faction] == nil) {
            print("Could not find color for \(faction)")
        }
        return darkColorDictionary[faction]
    }
    
    static func getDefaultButtonColor() -> UIColor {
        return getRGBColor(0, green: 122, blue: 255)
    }
}