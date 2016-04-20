//
//  IdentityTableCell.swift
//  Netdek
//
//  Created by Jason Baird on 11/23/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class IdentityTableCell: UITableViewCell {
    
    var identity: Identity!
    var deck: Deck!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var forwardButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setAttributes(identity: Identity, deck: Deck) {
        self.identity = identity
        self.deck = deck
        nameLabel.text = identity.card.name
        backgroundColor = ColorBuilder.getFactionColor(identity.card.faction)
    }
    
    @IBAction func pushForwardButton(sender: AnyObject) {
        deck.identity = identity
        print("Controller: \(window!.rootViewController!.presentedViewController!)")
        if let controller = findCurrentPresentedViewController() as? IdentityViewController {
            // TODO: This doesn't work yet
            controller.exitSegue()
        }
    }
    
    func findCurrentPresentedViewController() -> UIViewController {
        var controller = window!.rootViewController!
        var done = false
        while(!done) {
            if(controller.presentedViewController != nil) {
                controller = controller.presentedViewController!
            } else {
                done = true
            }
        }
        return controller
    }
    
}