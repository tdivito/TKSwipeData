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
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(self.startIndex, r.startIndex), end: advance(self.startIndex, r.endIndex)))
    }
}

struct TKSwipeData {
    let swipeData: String
    
    var cardHolder: String {
        get {
            var cardHolder = swipeData.componentsSeparatedByString("^")[1]
            var cardHolderParts = cardHolder.componentsSeparatedByString("/")
            return "\(cardHolderParts[1]) \(cardHolderParts[0])"
        }
    }
    
    var cardNumber: String {
        get {
            var charIndex = swipeData.rangeOfString("^")!
            var sIndex = advance(swipeData.startIndex, 2)
            var eIndex = advance(charIndex.endIndex, -1)
            return swipeData.substringWithRange(sIndex..<eIndex)
        }
    }
    
    var cardLastFour: String {
        get {
            var eIndex = advance(cardNumber.endIndex, -4)
            return cardNumber.substringFromIndex(eIndex)
        }
    }
    
    var cardExpiration: String {
        get {
            var expParts = swipeData.componentsSeparatedByString("^")[2]
            return "\(expParts[2..<4])\(expParts[0..<2])"
        }
    }
    
    init(swipeData: String) {
        self.swipeData = swipeData
    }
    
    func maskedCardNumber(mask: String = "X") -> String {
        var eIndex = advance(cardNumber.endIndex, -4)
        var maskCharacters = ""
        
        for i in 0..<count(cardNumber.substringToIndex(eIndex)) {
            maskCharacters = maskCharacters + mask
        }
        
        return "\(maskCharacters)\(cardNumber.substringFromIndex(eIndex))"
    }
    
    func formattedExpiration(divider: String) -> String {
        var idx = advance(cardExpiration.startIndex, 2)
        var month = cardExpiration.substringToIndex(idx)
        var year  = cardExpiration.substringFromIndex(idx)
        return "\(month)\(divider)\(year)"
    }
}