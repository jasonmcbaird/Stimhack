//
//  CoreCounter.swift
//  Stimhack
//
//  Created by Jason Baird on 11/25/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class CardOwnedCounter {
    
    static var coreCounts: [String: Int] = ["Aggressive Secretary": 2, "Hiemdall 1.0": 2, "Rototurret": 2, "Viktor 1.0": 2, "Archived Memories": 2, "Shipment from MirrorMorph": 2, "Corporate Troubleshooter": 1, "Experiential Data": 2, "Zaibatsu Loyalty": 1, "Cell Portal": 2, "Chum": 2, "Data Mine": 2, "Neural EMP": 2, "Akitaro Watanabe": 1, "AstroScript Pilot Program": 2, "Breaking News": 2, "Anonymous Tip": 2, "Closed Accounts": 2, "Psychographics": 2, "SEA Source": 2, "Red Herrings": 2, "SanSan City Grid": 1, "Posted Bounty": 2, "Security Subcontract": 1, "Archer": 2, "Hadrian's Wall": 2, "Aggressive Negotiation": 2, "Scorched Earth": 2, "Shipment from Kaguya": 2, "Research Station": 2, "Melange Mining Corp.": 2, "Hunter": 2, "Déjà Vu": 2, "Grimoire": 1, "Corroder": 2, "Datasucker": 2, "Djinn": 2, "Medium": 2, "Mimic": 2, "Wyrm": 2, "Yog.0": 2, "Ice Carver": 1, "Wyldside": 2, "Account Siphon": 2, "Desperado": 1, "Lemuria Codecracker": 2, "Aurora": 2, "Femme Fatale": 2, "Ninja": 2, "Sneakdoor Beta": 2, "Bank Job": 2, "Crash Space": 2, "Data Dealer": 1, "Decoy": 2, "Modded": 2, "The Toolbox": 1, "Akamatsu Mem Chip": 2, "Rabbit Hole": 2, "The Personal Touch": 2, "Battering Ram": 2, "Magnum Opus": 2, "Net Shield": 2, "Pipeline": 2, "Aesop's Pawnshop": 1, "Sacrificial Construct": 2]
    
    static func getCardOwnedCount(card: Card) -> Int {
        let settings = SettingsManager.loadSettings()
        if(!settings.sets.containsObject(card.set)) {
            return 0
        }
        if(card.set == "Core Set") {
            if(coreCounts[card.name] != nil) {
                return Int(settings.coreSetCount) * coreCounts[card.name]!
            } else {
                return 3
            }
        }
        return 3
    }
    
}