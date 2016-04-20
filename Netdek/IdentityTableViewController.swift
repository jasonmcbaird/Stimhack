//
//  IdentityTableViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/23/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class IdentityTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var deck: Deck
    var tableView: UITableView
    var runner: Bool
    var imageView: UIImageView
    
    init(tableView: UITableView, deck: Deck, runner: Bool, imageView: UIImageView) {
        self.tableView = tableView
        self.deck = deck
        self.runner = runner
        self.imageView = imageView
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
        let identity = getFilteredCardList()[indexPath.row].type as! Identity
        let cell: IdentityTableCell = tableView.dequeueReusableCellWithIdentifier("IdentityTableCell")! as! IdentityTableCell
        cell.setAttributes(identity, deck: deck)
        return cell
    }
    
    func getFilteredCardList() -> [Card] {
        var result: [Card] = []
        if(runner) {
            result = CoreDataLoader.getAllRunnerCards()
        } else {
            result = CoreDataLoader.getAllCorpCards()
        }
        return CardSorter.complexSort(CardFilterer.filter(result, filters: [TypeFilter(type: "Identity"), SetFilter(sets: SettingsManager.loadSettings().sets.allObjects as! [String])]))
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Update image
        let identity = getFilteredCardList()[indexPath.row].type as! Identity
        showCardImage(identity.card)
    }
    
    func showCardImage(card: Card) {
        if(card.getImage() != nil) {
            print("Displaying image for \(card.name)")
            imageView.image = card.getImage()
            imageView.hidden = false
        } else {
            if(card.image != "") {
                if(imageView.image == nil || imageView.hidden) {
                    imageView.image = UIImage(named: "BlankCard")
                }
                imageView.hidden = false
                let imageDownloader = ImageDownloader(downloadAction: CardImageUpdateAction(imageView: imageView))
                imageDownloader.downloadCardImageByNumber(card, number: card.image)
            } else {
                print("No image found")
            }
        }
    }
}