//
//  DeckChoiceTableViewCell.swift
//  Netdek
//
//  Created by Jason Baird on 11/21/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class DeckChoiceTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var deckNameTextView: UITextField!
    @IBOutlet var identityButton: UIButton!
    
    var deck: Deck!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setAttributes(deck: Deck) {
        self.deck = deck
        backgroundColor = ColorBuilder.getFactionColor(deck.identity.card.faction)
        deckNameTextView.text = deck.name
        identityButton.setTitle(deck.identity.card.name, forState: .Normal)
        deckNameTextView.delegate = self
        deckNameTextView.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func pushIdentityButton(sender: AnyObject) {
        deck.name = deckNameTextView.text!
        CoreDataCreator.save()
        if let controller = findCurrentPresentedViewController() as? DeckSelectionViewController {
            controller.segueToIdentity(deck)
        }
    }
    
    @IBAction func pushForwardButton(sender: AnyObject) {
        if(deck.name == "") {
            return
        }
        deck.name = deckNameTextView.text!
        CoreDataCreator.save()
        if let controller = findCurrentPresentedViewController() as? DeckSelectionViewController {
            controller.segueToDeckbuilding(deck)
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
    
    func textFieldDidChange(textField: UITextField) {
        deck.name = textField.text!
    }
    
}