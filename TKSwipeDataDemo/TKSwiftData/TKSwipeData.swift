//
//  TKSwipeData.swift
//  TKSwipeDataDemo
//
//  Created by Trent Kocurek on 9/15/15.
//  Available at https://github.com/t2/TKSwipeData
//  Copyright (c) 2015 Trent Kocurek. All rights reserved.
//
//  Updated by Tim DiVito on 9/23/2017 for Swift 4
//
//


import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
    
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    
}

struct TKSwipeData {
    var swipeData: String
    
    var cardHolder: String {
        get {
            let cardHolder = swipeData.components(separatedBy: "^")[1]
            if cardHolder.contains("/") {
                let cardHolderParts = cardHolder.components(separatedBy: "/")
                if cardHolderParts.count > 1 {
                    return "\(cardHolderParts[1]) \(cardHolderParts[0])"
                }
                else {
                    return cardHolderParts[0]
                }
            }
            else {
                return cardHolder
            }
        }
    }
    
    var cardNumber: String {
        get {
            let charIndex = swipeData.range(of: "^")
            let sIndex = swipeData.index(swipeData.startIndex, offsetBy: 2)
            let eIndex = swipeData.index((charIndex?.lowerBound)!, offsetBy: -1)
            return String(swipeData[sIndex...eIndex])
        }
    }
    
    var cardLastFour: String {
        get {
            let sIndex = cardNumber.index(cardNumber.endIndex, offsetBy: -4)
            return String(cardNumber[sIndex...])
        }
    }
    
    var cardExpiration: String {
        get {
            let expParts = swipeData.components(separatedBy: "^")[2]
            return "\(expParts[2..<4])\(expParts[0..<2])"
        }
    }
    
    init(swipeData: String) {
        self.swipeData = swipeData
    }
    
    func maskedCardNumber(mask: String = "X") -> String {
        let eIndex = cardNumber.index(cardNumber.endIndex, offsetBy: -4)
        let sIndex = cardNumber.index(cardNumber.startIndex, offsetBy: 0)
        var maskCharacters = ""
        let distanceCount = cardNumber.distance(from: sIndex, to: eIndex)
        
        for _ in 0...distanceCount {
            maskCharacters = maskCharacters + mask
        }
        
        return "\(maskCharacters)\(cardLastFour)"
    }
    
    
    func formattedExpiration(divider: String) -> String {
        let month = cardExpiration[cardExpiration.index(cardExpiration.startIndex, offsetBy: 2)...]
        let year = cardExpiration[...cardExpiration.index(cardExpiration.endIndex, offsetBy: -3)]
        return "\(month)\(divider)\(year)"
    }
}
 
