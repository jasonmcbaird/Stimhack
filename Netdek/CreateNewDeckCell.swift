//
//  CreateNewDeckCell.swift
//  Netdek
//
//  Created by Jason Baird on 11/21/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class CreateNewDeckCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func pushAddRunnerButton(sender: AnyObject) {
        DeckBuilder.createDeck("New Deck", identity: CoreDataLoader.getCardByName("Noise: Hacker Extraordinaire")!.type as! Identity)
        if let controller = findCurrentPresentedViewController() as? DeckSelectionViewController {
            controller.tableView.reloadData()
        }
    }
    
    @IBAction func pushAddCorpButton(sender: AnyObject) {
        DeckBuilder.createDeck("New Deck", identity: CoreDataLoader.getCardByName("Weyland Consortium: Building a Better World")!.type as! Identity)
        if let controller = findCurrentPresentedViewController() as? DeckSelectionViewController {
            controller.tableView.reloadData()
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