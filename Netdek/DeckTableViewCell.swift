//
//  DeckTableViewCell.swift
//  Netdek
//
//  Created by Jason Baird on 11/18/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import UIKit

class DeckTableViewCell: UITableViewCell {
    
    var playset: Playset!
    var deck: Deck!
    
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var subtypeLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setAttributes(playset: Playset, deck: Deck) {
        self.playset = playset
        self.deck = deck
        countLabel.text = "\(playset.count)x "
        nameLabel.text = playset.card.name
        let subtypeArray = playset.card.type.subtypes.allObjects as! [String]
        if(subtypeArray.count > 0 && subtypeArray[0] != "") {
            let string = playset.card.type.name + ": "  + subtypeArray.joinWithSeparator(" - ")
            subtypeLabel.text = "  " + string
        } else {
            subtypeLabel.text = "  \(playset.card.type.name)"
        }
        backgroundColor = ColorBuilder.getFactionColor(playset.card.faction)
        if(Int(playset.count) >= playset.card.getMaxDeckCount()) {
            addButton.tintColor = UIColor.grayColor()
            addButton.enabled = false
        } else {
            addButton.tintColor = ColorBuilder.getDefaultButtonColor()
            addButton.enabled = true
        }
    }
    
    @IBAction func pushAddButton(sender: AnyObject) {
        deck.addCard(playset.card)
    }
    
    @IBAction func pushMinusButton(sender: AnyObject) {
        deck.removeCard(playset.card)
    }
    
}