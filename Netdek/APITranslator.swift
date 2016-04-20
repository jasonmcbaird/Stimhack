//
//  Translator.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class APITranslator {
    
    /** Translation still to do:
        Remove backslashes before forward slashes
        Add backslashes before quotes except when already there
        Whatever the hell is going on with Slawomir Maniak's "l"
            - Unicode characters. \u0001 -> \u{0001}
    */
    
    static func translateFullAPI(string: String) -> [[String: AnyObject]] {
        let modifiedString = modifySpecialCharacters(string)
        var result: [[String: AnyObject]] = []
        for item in splitAPIToArray(modifiedString) {
            result.append(translateAPIObjectToDictionary(item))
        }
        return result
    }
    
    static func modifySpecialCharacters(string: String) -> String {
        var result = removeDoubleSlashes(string)
        result = interpretSpecialCharacters(string)
        return result
    }
    
    static func removeDoubleSlashes(string: String) -> String {
        let array = string.componentsSeparatedByString("\\/")
        return array.joinWithSeparator("/")
    }
    
    static func interpretSpecialCharacters(string: String) -> String {
        let array = string.componentsSeparatedByString("\\u")
        var result = ""
        for i in 0...array.count - 1 {
            var string = array[i]
            if(i > 0) {
                let range = Range(start: string.startIndex, end: string.startIndex.advancedBy(4))
                let code = string.substringWithRange(range)
                var charCode : UInt32 = 0
                NSScanner(string: code).scanHexInt(&charCode)
                string.replaceRange(range, with: String(UnicodeScalar(charCode)))
            }
            result += string
        }
        return result
    }
    
    static func splitAPIToArray(string: String) -> [String] {
        var trimmedString = string
        trimmedString = trimIfFirstCharacter(trimmedString, character: "[")
        trimmedString = trimIfLastCharacter(trimmedString, character: "]")
        let array = trimmedString.componentsSeparatedByString("},{")
        return array
    }
    
    static func translateAPIObjectToDictionary(string: String) -> [String: AnyObject] {
        let trimmedString = trimCurlyBraces(string)
        let initialArray = trimmedString.componentsSeparatedByString(",\"")
        return apiArrayToDictionary(initialArray)
    }
    
    static func trimCurlyBraces(string: String) -> String {
        var trimmedString = string
        trimmedString = trimIfFirstCharacter(trimmedString, character: "{")
        trimmedString = trimIfLastCharacter(trimmedString, character: "}")
        return trimmedString
    }
    
    static func apiArrayToDictionary(array: [String]) -> [String: AnyObject] {
        var resultDictionary: [String: AnyObject] = Dictionary()
        for item in array {
            /**if(item == array[array.count - 1]) {
                let result = trimIfLastCharacter(item, character: "\"")
                resultDictionary = addedToDictionary(getAPIKey(result), anyObject: getAPIValue(result), dictionary: resultDictionary)
            } else if(item == array[0]) {
                let result = trimIfFirstCharacter(item, character: "\"")
                resultDictionary = addedToDictionary(getAPIKey(result), anyObject: getAPIValue(result), dictionary: resultDictionary)
            } else {*/
            var key = getAPIKey(item)
            key = trimIfFirstCharacter(key, character: "\"")
            key = trimIfLastCharacter(key, character: "\"")
            var value = getAPIValue(item)
            if(value is String) {
                value = trimIfFirstCharacter(value as! String, character: "\"")
                value = trimIfLastCharacter(value as! String, character: "\"")
            }
            resultDictionary = addedToDictionary(key, anyObject: value, dictionary: resultDictionary)
            //}
        }
        return resultDictionary
    }
    
    static func getAPIKey(string: String) -> String {
        return string.componentsSeparatedByString("\":")[0]
    }
    
    static func getAPIValue(string: String) -> AnyObject {
        let split = string.componentsSeparatedByString("\":")
        if let number = NSNumberFormatter().numberFromString(split[1]) {
            return number.integerValue
        } else {
            return split[1]
        }
    }
    
    static func addedToDictionary(string: String, anyObject: AnyObject, dictionary: [String: AnyObject]) -> [String: AnyObject] {
        var newDictionary = dictionary
        newDictionary[string] = anyObject
        return newDictionary
    }
    
    static func trimIfFirstCharacter(string: String, character: Character) -> String {
        var trimmedString = string
        if(trimmedString[trimmedString.startIndex] == character) {
            trimmedString = String(trimmedString.characters.dropFirst())
        }
        return trimmedString
    }
    
    static func trimIfLastCharacter(string: String, character: Character) -> String {
        var trimmedString = string
        if(trimmedString[trimmedString.startIndex.advancedBy(trimmedString.characters.count - 1)] == character) {
            trimmedString = String(trimmedString.characters.dropLast())
        }
        return trimmedString
    }
}