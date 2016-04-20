//
//  DeselectableSegmentedControl.swift
//  Netdek
//
//  Created by Jason Baird on 11/23/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class DeselectableSegmentedControl: UISegmentedControl {
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let current = selectedSegmentIndex
        super.touchesEnded(touches, withEvent: event)
        if(current == selectedSegmentIndex) {
            selectedSegmentIndex = -1
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
    
}