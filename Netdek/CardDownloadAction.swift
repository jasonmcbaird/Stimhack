//
//  DownloadCardAction.swift
//  Netdek
//
//  Created by Jason Baird on 11/15/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class CardDownloadAction: DownloadAction {
    
    func finishDownload(url: String, object: AnyObject, target: AnyObject?) {
        CardBuilder.createAllCardsFromAPI(object as! String)
        /**for card in array {
            var done = false
            while !done {
                let cardToDelete = CoreDataLoader.getCardByName(card.name)
                if(cardToDelete != nil) {
                    CoreDataLoader.deleteCard(cardToDelete!)
                    print("Deleting card \(cardToDelete!.name)")
                } else {
                    done = true
                }
            }
        }*/
        let settings = SettingsManager.loadSettings()
        settings.allSets = NSSet(array: SettingsManager.getAllSets())
        settings.sets = settings.allSets
        print("Done downloading all cards.")
        CoreDataCreator.save()
    }
}