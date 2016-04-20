//
//  ViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/13/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import UIKit

class DeckbuilderViewController: UIViewController, CellSelectionResponder, UISearchBarDelegate {
    
    @IBOutlet var cardImageHolderView: UIView!
    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var deckTableView: UITableView!
    
    @IBOutlet var cardPoolHolderView: UIStackView!
    @IBOutlet var cardPoolTableView: UITableView!
    @IBOutlet var cardImageLoadingSpinner: UIActivityIndicatorView!
    @IBOutlet var cardFilterTypeControl: DeselectableSegmentedControl!
    @IBOutlet var cardFilterCostControl: DeselectableSegmentedControl!
    @IBOutlet var cardFilterInfluenceControl: DeselectableSegmentedControl!
    @IBOutlet var cardFilterFactionControl: DeselectableSegmentedControl!
    @IBOutlet var cardFilterSearchBar: UISearchBar!
    @IBOutlet var cardFilterSearchControl: UISegmentedControl!
    
    @IBOutlet var deckSizeLabeL: UILabel!
    @IBOutlet var deckInfluenceLabel: UILabel!
    @IBOutlet var deckIdentityButton: UIButton!
    @IBOutlet var deckVisualButton: UIButton!
    
    var deck: Deck!
    var cardPoolController: CardPoolTableViewController!
    var deckTableController: DeckTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardPoolTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        if(deck != nil) {
            print("Deck: \(deck.name), identity: \(deck.identity.card.name), card count: \(deck.getCardCount())")
        } else {
            print("No deck")
        }
        
        NSNotificationCenter.defaultCenter().addObserver(deck, forKeyPath: "DeckChanged", options: NSKeyValueObservingOptions(), context: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateDeckInfo:", name: "DeckChanged", object: nil)
        
        cardPoolController = CardPoolTableViewController(tableView: cardPoolTableView, cellSelectionResponder: self, deck: deck)
        deckTableController = DeckTableViewController(tableView: deckTableView, cellSelectionResponder: self, deck: deck)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        cardImageView.userInteractionEnabled = true
        cardImageView.addGestureRecognizer(tapGestureRecognizer)
        updateDeckInfo()
        cardPoolController.tableView(cardPoolTableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        cardImageHolderView.hidden = true
        if(deck.identity.card.side == "Corp") {
            cardFilterTypeControl.setTitle("Agenda", forSegmentAtIndex: 0)
            cardFilterTypeControl.setTitle("ICE", forSegmentAtIndex: 1)
            cardFilterTypeControl.setTitle("Asset", forSegmentAtIndex: 2)
            cardFilterTypeControl.setTitle("Upgrade", forSegmentAtIndex: 3)
            cardFilterTypeControl.setTitle("Operation", forSegmentAtIndex: 4)
            
            cardFilterFactionControl.insertSegmentWithTitle("HB", atIndex: 0, animated: false)
            cardFilterFactionControl.setTitle("Jinteki", forSegmentAtIndex: 1)
            cardFilterFactionControl.setTitle("NBN", forSegmentAtIndex: 2)
            cardFilterFactionControl.setTitle("Weyland", forSegmentAtIndex: 3)
        }
        setFilters()
    }
    
    override func viewDidLayoutSubviews() {
        setCardPoolVisibility()
        updateDeckInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeCardFilterControl(sender: AnyObject) {
        setFilters()
    }
    
    func reloadCardPoolTableView() {
        cardPoolTableView.reloadData()
    }
    
    func reloadDeckTableView() {
        deckTableView.reloadData()
    }
    
    func showCardImage(card: Card) {
        if(card.getImage() != nil) {
            print("Displaying image for \(card.name)")
            cardImageView.image = card.getImage()
            cardImageHolderView.hidden = false
            setCardPoolVisibility()
        } else {
            if(card.image != "") {
                if(cardImageView.image == nil || cardImageHolderView.hidden) {
                    cardImageView.image = UIImage(named: "BlankCard")
                }
                cardImageHolderView.hidden = false
                cardImageLoadingSpinner.hidden = false
                let imageDownloader = ImageDownloader(downloadAction: CardImageUpdateAction(imageView: cardImageView))
                imageDownloader.downloadCardImageByNumber(card, number: card.image)
            } else {
                print("No image found")
            }
        }
    }
    
    func imageTapped(img: AnyObject) {
        cardImageHolderView.hidden = true
        setCardPoolVisibility()
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        setCardPoolVisibility()
        updateDeckIdentity()
    }
    
    func setCardPoolVisibility() {
        if(UIDevice.currentDevice().orientation == .Portrait && UIDevice.currentDevice().userInterfaceIdiom != .Pad) {
            cardPoolHolderView.hidden = true
        } else {
            cardPoolHolderView.hidden = false
        }
    }
    
    func updateDeckInfo(notification: NSNotification) {
        updateDeckInfo()
    }
    
    func updateDeckInfo() {
        updateDeckIdentity()
        deckSizeLabeL.text = "\(deck.getCardCount())/\(deck.identity.deckSize)"
        deckInfluenceLabel.text = "\(deck.getInfluenceCount())/\(deck.identity.influencePoints)"
        deckInfluenceLabel.textColor = ColorBuilder.getDarkFactionColor(deck.identity.card.faction)
        if(deck.getCardCount() < 1) {
            deckVisualButton.enabled = false
        } else {
            deckVisualButton.enabled = true
        }
        highlightIllegalNumbers()
        reloadDeckTableView()
    }
    
    func updateDeckIdentity() {
        if(UIDevice.currentDevice().orientation != .Portrait) {
            let splitName = deck.identity.card.name.componentsSeparatedByString(":")
            if(splitName.count > 1) {
                if(splitName[0] == "Weyland Consortium") {
                    deckIdentityButton.setTitle("Weyland", forState: .Normal)
                    return
                }
                deckIdentityButton.setTitle(splitName[0], forState: .Normal)
                return
            }
        }
        deckIdentityButton.setTitle(deck.identity.card.name, forState: .Normal)
    }
    
    func highlightIllegalNumbers() {
        if(!deck.isSizeLegal()) {
            deckSizeLabeL.textColor = UIColor.redColor()
        } else {
            deckSizeLabeL.textColor = UIColor.blackColor()
        }
        if(!deck.isInfluenceLegal()) {
            deckInfluenceLabel.textColor = UIColor.redColor()
        }
    }
    
    func selectCell(card: Card) {
        showCardImage(card)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowVisualDeckViewSegue" {
            if let destinationVC = segue.destinationViewController as? VisualDeckViewController {
                destinationVC.deck = deck
            }
        }
        if segue.identifier == "ShowIdentitySegue" {
            if let destinationVC = segue.destinationViewController as? IdentityViewController {
                destinationVC.segueToDeckbuilding = true
                destinationVC.deck = deck
            }
        }
    }
    
    @IBAction func segueToVisual(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowVisualDeckViewSegue", sender: self)
        print("Moving to visual deck view for \(deck.name)")
    }
    
    @IBAction func returnToDeckbuildingView(segue: UIStoryboardSegue) {
        deckTableController.tableView.reloadData()
        cardPoolController.tableView.reloadData()
    }
    
    func setFilters() {
        var filters: [Filter] = []
        if(cardFilterTypeControl.selectedSegmentIndex != -1) {
            filters.append(TypeFilter(type: cardFilterTypeControl.titleForSegmentAtIndex(cardFilterTypeControl.selectedSegmentIndex)!))
            //print("Set type filter: \(cardFilterTypeControl.titleForSegmentAtIndex(cardFilterTypeControl.selectedSegmentIndex)!)")
        }
        if(cardFilterCostControl.selectedSegmentIndex != -1) {
            if(cardFilterCostControl.selectedSegmentIndex != cardFilterCostControl.numberOfSegments - 1) {
                let cost: Int = Int(cardFilterCostControl.titleForSegmentAtIndex(cardFilterCostControl.selectedSegmentIndex)!)!
                filters.append(CostFilter(cost: cost))
                //print("Set cost filter: \(cardFilterCostControl.titleForSegmentAtIndex(cardFilterCostControl.selectedSegmentIndex)!)")
            } else {
                let cost: Int = getIntFromString(cardFilterCostControl.titleForSegmentAtIndex(cardFilterCostControl.selectedSegmentIndex)!)!
                filters.append(GreaterOrEqualCostFilter(cost: cost))
                //print("Set cost filter: \(cardFilterCostControl.titleForSegmentAtIndex(cardFilterCostControl.selectedSegmentIndex)!)")
            }
        }
        if(cardFilterInfluenceControl.selectedSegmentIndex != -1) {
            filters.append(InfluenceFilter(influence: Int(cardFilterInfluenceControl.titleForSegmentAtIndex(cardFilterInfluenceControl.selectedSegmentIndex)!)!))
            //print("Set type filter: \(cardFilterInfluenceControl.titleForSegmentAtIndex(cardFilterInfluenceControl.selectedSegmentIndex)!)")
        }
        if(cardFilterFactionControl.selectedSegmentIndex != -1) {
            var faction = cardFilterFactionControl.titleForSegmentAtIndex(cardFilterFactionControl.selectedSegmentIndex)!
            if faction == "HB" {
                faction = "Haas-Bioroid"
            }
            if faction == "Weyland" {
                faction = "Weyland-Consortium"
            }
            if faction == "NBN" {
                faction = "Nbn"
            }
            filters.append(FactionFilter(faction: faction))
        }
        if(cardFilterSearchBar.text != nil && cardFilterSearchBar.text != "") {
            if(cardFilterSearchControl.selectedSegmentIndex == 0) {
                filters.append(NameFilter(name: cardFilterSearchBar.text!))
            } else {
                filters.append(TextFilter(text: cardFilterSearchBar.text!))
            }
        }
        filters.append(SetFilter(sets: SettingsManager.loadSettings().sets.allObjects as! [String]))
        cardPoolController.filters = filters
        cardPoolController.tableView.reloadData()
    }
    
    func getIntFromString(string: String) -> Int? {
        let scanner = NSScanner(string: string)
        var value: Int = 0
        scanner.scanUpToCharactersFromSet(NSCharacterSet.decimalDigitCharacterSet(), intoString: nil)
        if scanner.scanInteger(&value) {
            print("Scan result: \(value)")
            return value
        }
        else {
            print("Can't scan integer from \(string)")
            return nil
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        setFilters()
    }
    
    // TODO: Stop loading other images when you click a new one.
    // To do this, hold one CardImageUpdateAction at a time. When you get a new one, clear the old one's connection to you.
}