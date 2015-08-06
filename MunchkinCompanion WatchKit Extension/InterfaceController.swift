//
//  InterfaceController.swift
//  Counter Alternate 1 WatchKit Extension
//
//  Created by Alex on 8/3/15.
//  Copyright (c) 2015 MentalCake. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var levelSlider: WKInterfaceSlider!
    @IBOutlet weak var combatSlider: WKInterfaceSlider!
    @IBOutlet weak var oneShotSlider: WKInterfaceSlider!
    @IBOutlet weak var resetButton: WKInterfaceButton!
    @IBOutlet weak var totalsLabel: WKInterfaceLabel!
    
    var totalValue = 1
    var levelValue = 1
    var combatValue = 0
    var oneShotValue = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func levelSliderDidChange(value: Float) {
        levelValue = Int(value)
        totalValue = levelValue + combatValue + oneShotValue
        totalsLabel.setText("\(totalValue)")
        
    }
    
    @IBAction func combatSliderDidChange(value: Float) {
        combatValue = Int(value)
        totalValue = levelValue + combatValue + oneShotValue
        totalsLabel.setText("\(totalValue)")
    }
    
    @IBAction func oneShotSliderDidChange(value: Float) {
        oneShotValue = Int(value)
        totalValue = levelValue + combatValue + oneShotValue
        totalsLabel.setText("\(totalValue)")
        if value < 0 {
            oneShotSlider.setColor(UIColor.orangeColor())
        } else {
            oneShotSlider.setColor(UIColor.yellowColor())
        }
    }
    
    @IBAction func resetButtonPressed() {
        levelSlider.setValue(1)
        combatSlider.setValue(0)
        oneShotSlider.setValue(0)
        totalValue = 1
        levelValue = 1
        combatValue = 0
        oneShotValue = 0
        totalsLabel.setText("\(totalValue)")
        oneShotSlider.setColor(UIColor.yellowColor())
    }
}


