//
//  ImageDownloader.swift
//  Netdek
//
//  Created by Jason Baird on 11/15/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    
    var downloadAction: DownloadAction
    
    init(downloadAction: DownloadAction) {
        self.downloadAction = downloadAction
    }
    
    func downloadCardImage(card: Card, string: String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let url = Downloader.getURL(string)
            print("Downloading card image from \(url)")
            let task = self.buildTask(url, card: card)
            task.resume()
        }
    }
    
    func downloadCardImageByNumber(card: Card, number: String) {
        downloadCardImage(card, string: "bundles/netrunnerdbcards/images/cards/en/\(number)")
    }
    
    func buildTask(url: NSURL, card: Card) -> NSURLSessionDataTask {
        let request = Downloader.buildRequest(url)
        return NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            Downloader.printIfError(error)
            let image = UIImage(data: data!)
            if(image != nil) {
                NSOperationQueue.mainQueue().addOperationWithBlock( {
                    self.downloadAction.finishDownload(url.absoluteString, object: image!, target: card)
                })
            }
        }
    }
    
}