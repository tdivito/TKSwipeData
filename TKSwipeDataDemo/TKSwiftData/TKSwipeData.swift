//
//  TKSwipeData.swift
//  TKSwipeDataDemo
//
//  Created by Trent Kocurek on 9/15/15.
//  Copyright (c) 2015 Trent Kocurek. All rights reserved.
//

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: self.startIndex.advancedBy(r.startIndex), end: self.startIndex.advancedBy(r.endIndex)))
    }
}

struct TKSwipeData {
    var swipeData: String
    
    var cardHolder: String {
        get {
            let cardHolder = swipeData.componentsSeparatedByString("^")[1]
            if cardHolder.containsString("/") {
                let cardHolderParts = cardHolder.componentsSeparatedByString("/")
                if cardHolderParts.count > 1 {
                    return "\(cardHolderParts[1]) \(cardHolderParts[0])"
                }
                else {
                    return cardHolderParts[1]
                }
            }
            else {
                return cardHolder
            }
        }
    }
    
    var cardNumber: String {
        get {
            let charIndex = swipeData.rangeOfString("^")!
            let sIndex = swipeData.startIndex.advancedBy(2)
            let eIndex = charIndex.endIndex.advancedBy(-1)
            return swipeData.substringWithRange(sIndex..<eIndex)
        }
    }
    
    var cardLastFour: String {
        get {
            let eIndex = cardNumber.endIndex.advancedBy(-4)
            return cardNumber.substringFromIndex(eIndex)
        }
    }
    
    var cardExpiration: String {
        get {
            let expParts = swipeData.componentsSeparatedByString("^")[2]
            return "\(expParts[2..<4])\(expParts[0..<2])"
        }
    }
    
    init(swipeData: String) {
        self.swipeData = swipeData
    }
    
    func maskedCardNumber(mask: String = "X") -> String {
        let eIndex = cardNumber.endIndex.advancedBy(-4)
        var maskCharacters = ""
        
        for _ in 0..<cardNumber.substringToIndex(eIndex).characters.count {
            maskCharacters = maskCharacters + mask
        }
        
        return "\(maskCharacters)\(cardNumber.substringFromIndex(eIndex))"
    }
    
    func formattedExpiration(divider: String) -> String {
        let idx = cardExpiration.startIndex.advancedBy(2)
        let month = cardExpiration.substringToIndex(idx)
        let year  = cardExpiration.substringFromIndex(idx)
        return "\(month)\(divider)\(year)"
    }
}
