//
//  ViewController.swift
//  TKSwipeDataDemo
//
//  Created by Trent Kocurek on 9/15/15.
//  Copyright (c) 2015 Trent Kocurek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var swipeDataInput:    UITextField!
    @IBOutlet weak var cardHolderLbl:     UILabel!
    @IBOutlet weak var cardNumberLbl:     UILabel!
    @IBOutlet weak var cardExpirationLbl: UILabel!
    @IBOutlet weak var cardLastFourLbl:   UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        parseSwipeData()
    }

    @IBAction func parseSwipeData() {
        var swipeData = TKSwipeData(swipeData: swipeDataInput.text)
        cardHolderLbl.text = swipeData.cardHolder
        cardNumberLbl.text = swipeData.cardNumber
        cardExpirationLbl.text = swipeData.cardExpiration
        cardLastFourLbl.text = swipeData.cardLastFour
    }
}

