//
//  SetTableCell.swift
//  Netdek
//
//  Created by Jason Baird on 11/24/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class SetTableCell: UITableViewCell {
    
    var set: String!
    var settings: Settings!
    
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setAttributes(set: String, settings: Settings) {
        self.set = set
        self.settings = settings
        nameLabel.text = set
        updateBackground()
    }
    
    func updateBackground() {
        if(settings.sets.containsObject(set)) {
            backgroundColor = ColorBuilder.getFactionColor("Shaper")
        } else {
            backgroundColor = ColorBuilder.getFactionColor("Anarch")
        }
    }
    
}