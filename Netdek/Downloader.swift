//
//  CardDownloader.swift
//  Netdek
//
//  Created by Jason Baird on 11/15/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

class Downloader {
    
    static let serverURL = "http://netrunnerdb.com"
    var downloadAction: DownloadAction
    
    init(downloadAction: DownloadAction) {
        self.downloadAction = downloadAction
    }
    
    func download(string: String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let url = Downloader.getURL(string)
            let task = self.buildTask(url)
            task.resume()
        }
    }
    
    func buildTask(url: NSURL) -> NSURLSessionDataTask {
        let request = Downloader.buildRequest(url)
        return NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            Downloader.printIfError(error)
            let string = self.decodeData(data!)
            self.mainThreadFinish(url, string: string)
        }
    }
    
    static func printIfError(error: NSError?) {
        if error != nil {
            print("error=\(error)")
            return
        }
    }
    
    static func buildRequest(url: NSURL) -> NSMutableURLRequest {
        return NSMutableURLRequest(URL: url)
    }
    
    static func getURL(string: String) -> NSURL {
        return NSURL(string: "\(self.serverURL)/\(string)")!
    }
    
    func decodeData(data: NSData) -> String? {
        return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
    }
    
    func mainThreadFinish(url: NSURL, string: String?) {
        if(string != nil) {
            NSOperationQueue.mainQueue().addOperationWithBlock( {
                self.finishDownload(url, string: string!)
            })
        }
    }
    
    func finishDownload(url: NSURL, string: String) {
        //print("Request: \(url)")
        //print("Response: \(string)")
        downloadAction.finishDownload("\(url)", object: string, target: nil)
    }
    
}