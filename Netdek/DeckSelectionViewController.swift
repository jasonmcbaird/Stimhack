//
//  DeckSelectionViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/21/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class DeckSelectionViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var tableController: DeckChoiceTableViewController!
    
    var selectedDeck: Deck? = nil
    
    override func viewDidLoad() {
        tableController = DeckChoiceTableViewController(tableView: tableView)
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDeckbuilderSegue" {
            if let destinationVC = segue.destinationViewController as? DeckbuilderViewController {
                destinationVC.deck = selectedDeck
            }
        }
        if segue.identifier == "ShowIdentitySegue" {
            if let destinationVC = segue.destinationViewController as? IdentityViewController {
                destinationVC.deck = selectedDeck
            }
        }
    }
    
    func segueToDeckbuilding(deck: Deck) {
        self.selectedDeck = deck
        self.performSegueWithIdentifier("ShowDeckbuilderSegue", sender: self)
    }
    
    func segueToIdentity(deck: Deck) {
        self.selectedDeck = deck
        performSegueWithIdentifier("ShowIdentitySegue", sender: self)
    }
    
    @IBAction func returnToDeckMenu(segue: UIStoryboardSegue) {
        tableController.tableView.reloadData()
    }
}