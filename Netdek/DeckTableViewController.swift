//
//  DeckTableViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class DeckTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var deck: Deck!
    var tableView: UITableView!
    var filters: [Filter] = []
    var cellSelectionResponder: CellSelectionResponder!
    
    init(tableView: UITableView, cellSelectionResponder: CellSelectionResponder, deck: Deck) {
        self.tableView = tableView
        self.cellSelectionResponder = cellSelectionResponder
        self.deck = deck
        super.init(nibName: nil, bundle: nil)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiated a ComboController with the wrong constructor.")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getFilteredCardList().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let playset = deck.getPlayset(getFilteredCardList()[indexPath.row])!
        let cell: DeckTableViewCell = tableView.dequeueReusableCellWithIdentifier("DeckTableViewCell")! as! DeckTableViewCell
        cell.setAttributes(playset, deck: deck)
        return cell
    }
    
    func getFilteredCardList() -> [Card] {
        return CardSorter.complexSort(deck.getCards())
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cellSelectionResponder.selectCell(getFilteredCardList()[indexPath.row])
    }
}