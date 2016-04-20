//
//  CardPoolSubViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/19/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class CardPoolTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var deck: Deck!
    var runner: Bool = false
    var filters: [Filter] = []
    var tableView: UITableView!
    var cellSelectionResponder: CellSelectionResponder!
    
    init(tableView: UITableView, cellSelectionResponder: CellSelectionResponder, deck: Deck) {
        self.tableView = tableView
        self.cellSelectionResponder = cellSelectionResponder
        self.deck = deck
        super.init(nibName: nil, bundle: nil)
        tableView.dataSource = self
        tableView.delegate = self
        if(deck.getSide() == "Runner") {
            self.runner = true
        } else {
            self.runner = false
        }
    }
    
    // Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiated a ComboController with the wrong constructor.")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getFilteredCardList().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let card = getFilteredCardList()[indexPath.row]
        let cell: CardTableViewCell = tableView.dequeueReusableCellWithIdentifier("CardTableViewCell")! as! CardTableViewCell
        cell.setAttributes(card, deck: deck)
        return cell
    }
    
    func getFilteredCardList() -> [Card] {
        var unfilteredCards: [Card]
        if(runner) {
            unfilteredCards = CoreDataLoader.getAllRunnerCards()
        } else {
            unfilteredCards = CoreDataLoader.getAllCorpCards()
        }
        return CardSorter.complexSort(filter(unfilteredCards))
    }
    
    func filter(cards: [Card]) -> [Card] {
        if(filters.count == 0) {
            return cards
        } else {
            return CardFilterer.filter(cards, filters: filters, oppositeFilters: [TypeFilter(type: "Identity")])
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cellSelectionResponder.selectCell(getFilteredCardList()[indexPath.row])
    }
}