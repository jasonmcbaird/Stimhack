//
//  SetTableViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/24/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class SetTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    var settings: Settings
    var setNumbers: [String: Int]!
    
    init(tableView: UITableView, settings: Settings) {
        self.tableView = tableView
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
        tableView.dataSource = self
        tableView.delegate = self
        setupSetNumbers()
    }
    
    // Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiated a controller with the wrong constructor.")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSortedSets().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let set = getSortedSets()[indexPath.row]
        let cell: SetTableCell = tableView.dequeueReusableCellWithIdentifier("SetTableCell")! as! SetTableCell
        cell.setAttributes(set, settings: settings)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SetTableCell
        if(settings.sets.containsObject(cell.set)) {
            settings.removeSet(cell.set)
        } else {
            settings.addSet(cell.set)
        }
        CoreDataCreator.save()
        cell.updateBackground()
    }
    
    func getSortedSets() -> [String] {
        var sets: [String] = []
        for set in setNumbers.keys {
            sets.append(set)
        }
        return sets.sort({setNumbers[$0] < setNumbers[$1]})
    }
    
    func setupSetNumbers() {
        var result: [String: Int] = Dictionary()
        for set in settings.allSets {
            result.updateValue(getSetNumber(set as! String), forKey: set as! String)
        }
        setNumbers = result
    }
    
    func getSetNumber(set: String) -> Int {
        let cards = CoreDataLoader.getAllCards()
        for card in cards {
            if(card.set == set) {
                return Int(card.image.substringToIndex(card.image.startIndex.advancedBy(5)))!
            }
        }
        return 100
    }
}