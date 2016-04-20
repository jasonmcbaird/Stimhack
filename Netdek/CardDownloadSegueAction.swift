//
//  CardDownloadSegueAction.swift
//  Netdek
//
//  Created by Jason Baird on 11/17/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class CardDownloadSegueAction: DownloadAction {
    
    var targetScreen: MainMenuViewController
    
    init(targetScreen: MainMenuViewController) {
        self.targetScreen = targetScreen
    }
    
    func finishDownload(url: String, object: AnyObject, target: AnyObject?) {
        CardDownloadAction().finishDownload(url, object: object, target: target)
        targetScreen.segueToDeckChoice()
    }
}