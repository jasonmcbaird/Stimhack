//
//  IdentityViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/23/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class IdentityViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    var tableController: IdentityTableViewController!
    var segueToDeckbuilding: Bool = false
    
    var deck: Deck!
    var runner: Bool!
    
    override func viewDidLoad() {
        runner = deck.identity.card.side == "Runner"
        tableController = IdentityTableViewController(tableView: tableView, deck: deck, runner: runner, imageView: imageView)
        tableView.reloadData()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func exitSegue() {
        print("Segueing to deckbuilding? \(segueToDeckbuilding)")
        if(segueToDeckbuilding) {
            performSegueWithIdentifier("UnwindToDeckbuildingSegue", sender: self)
        } else {
            performSegueWithIdentifier("UnwindToDeckSelectionSegue", sender: self)
        }
    }
    
    func imageTapped(img: AnyObject) {
        imageView.hidden = true
    }
    
    @IBAction func tapBackButton(sender: AnyObject) {
        CoreDataCreator.save()
        exitSegue()
    }
}