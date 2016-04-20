//
//  MainMenuViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/17/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewController: UIViewController {
    
    var runner: Bool = false
    var deck: Deck? = nil
    
    @IBAction func touchDownloadButton(sender: AnyObject) {
        if(sender is UIButton && (sender as! UIButton).titleForState(.Normal)!.containsString("Runner")) {
            runner = true
        } else {
            runner = false
        }
        if(CoreDataLoader.getAllCards().count <= 0) {
            Downloader(downloadAction: CardDownloadSegueAction(targetScreen: self)).download("api/cards/")
        } else {
            segueToDeckChoice()
        }
    }
    
    func segueToDeckChoice() {
        self.performSegueWithIdentifier("ShowDeckChoiceSegue", sender: self)
        print("Moving to deck choice screen.")
    }
    
    @IBAction func returnToMainMenu(segue: UIStoryboardSegue) {
        
    }
    
    // TODO: Disable Runner Deck while downloading.
}
