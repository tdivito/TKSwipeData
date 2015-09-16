//
//  TKSwipeDataDemoTests.swift
//  TKSwipeDataDemoTests
//
//  Created by Trent Kocurek on 9/15/15.
//  Copyright (c) 2015 Trent Kocurek. All rights reserved.
//

import UIKit
import XCTest

class TKSwipeDataDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func swipeData() -> TKSwipeData {
        return TKSwipeData(swipeData: "%B4111111111111111^SCULLY/DANA^1804101132071       00813000000?;4111111111111111=1804101132071813?")
    }
    
    func testCardHolder() {
        XCTAssertEqual(swipeData().cardHolder, "DANA SCULLY", "Card holder is incorrect")
    }
    
    func testCardNumber() {
        XCTAssertEqual(swipeData().cardNumber, "4111111111111111", "Card number is incorrect")
    }
    
    func testCardLastFour() {
        XCTAssertEqual(swipeData().cardLastFour, "1111", "Card last four is incorrect")
    }

    func testCardExpiration() {
        XCTAssertEqual(swipeData().cardExpiration, "0418", "Card expiration is incorrect")
    }
    
    func testMaskedCardNumber() {
        XCTAssertEqual(swipeData().maskedCardNumber(mask: "Y"), "YYYYYYYYYYYY1111", "Card mask is incorrect")
    }
    
    func testFormattedExpiration() {
        XCTAssertEqual(swipeData().formattedExpiration("/"), "04/18", "Card expiration format is incorrect")
    }
    
}
