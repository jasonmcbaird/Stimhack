//
//  DeckChoiceTableViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/21/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class DeckChoiceTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    var filters: [Filter] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init(nibName: nil, bundle: nil)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiated a Controller with the wrong constructor.")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSortedDecks().count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            return tableView.dequeueReusableCellWithIdentifier("CreateNewDeckCell")! as! CreateNewDeckCell
        }
        let deck = getSortedDecks()[indexPath.row - 1]
        let cell: DeckChoiceTableViewCell = tableView.dequeueReusableCellWithIdentifier("DeckChoiceTableViewCell")! as! DeckChoiceTableViewCell
        cell.setAttributes(deck)
        return cell
    }
    
    func getSortedDecks() -> [Deck] {
        return DeckSorter.complexSort(CoreDataLoader.getDecks())
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            CoreDataCreator.managedContext.deleteObject(CoreDataLoader.getDecks()[indexPath.row - 1])
            tableView.reloadData()
            CoreDataCreator.save()
        }
    }
}