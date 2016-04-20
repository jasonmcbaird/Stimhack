//
//  CoreSetTableCell.swift
//  Stimhack
//
//  Created by Jason Baird on 11/25/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class CoreSetTableCell: SetTableCell {
    
    @IBOutlet var stepper: UIStepper!
    
    override func setAttributes(set: String, settings: Settings) {
        super.setAttributes(set, settings: settings)
        updateNameLabel()
    }
    
    func updateNameLabel() {
        nameLabel.text = "\(settings.coreSetCount)x \(set)"
    }
    
    @IBAction func addSet() {
        // Implement this: When you hit +
        settings.coreSetCount++
        checkCoreCount()
        updateNameLabel()
    }
    
    @IBAction func removeSet() {
        // Implement this: When you hit -
        settings.coreSetCount--
        checkCoreCount()
        updateNameLabel()
    }
    
    func checkCoreCount() {
        if(settings.coreSetCount > 3) {
            settings.coreSetCount = 3
        }
        if(settings.coreSetCount < 0) {
            settings.coreSetCount = 0
        }
    }
    
    func updateStepper() {
        // Implement this: gray out - if @ zero, gray out + if @ 3
    }
}