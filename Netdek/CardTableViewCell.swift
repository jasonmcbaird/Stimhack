//
//  CardTableViewCell.swift
//  Netdek
//
//  Created by Jason Baird on 11/16/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    var card: Card!
    var deck: Deck!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var subtypeLabel: UILabel!
    @IBOutlet var addButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAttributes(card: Card, deck: Deck) {
        self.card = card
        self.deck = deck
        nameLabel.text = card.name
        let subtypeArray = card.type.subtypes.allObjects as! [String]
        if(subtypeArray.count > 0 && subtypeArray[0] != "") {
            let string = card.type.name + ": "  + subtypeArray.joinWithSeparator(" - ")
            subtypeLabel.text = "  " + string
        } else {
            subtypeLabel.text = "  \(card.type.name)"
        }
        if(SettingsManager.cellImageBackgroundsEnabled()) {
            let image = UIImage(named: "\(card.faction)Background")
            if(image != nil) {
                backgroundView = UIImageView.init(image: image)
                backgroundView!.contentMode = .ScaleAspectFill
            }
        }
        if(backgroundView == nil) {
            backgroundColor = ColorBuilder.getFactionColor(card.faction)
        }
    }
    
    @IBAction func pushAddButton(sender: AnyObject) {
        deck.addCard(card)
    }
}
