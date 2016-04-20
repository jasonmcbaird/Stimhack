//
//  CardImageSaveAction.swift
//  Netdek
//
//  Created by Jason Baird on 11/17/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class CardImageSaveAction: DownloadAction {
    
    func finishDownload(url: String, object: AnyObject, target: AnyObject?) {
        saveDownloadedImage(url, image: object as! UIImage, card: target as! Card)
    }
    
    func saveDownloadedImage(url: String, image: UIImage, card: Card) {
        let fileManager = NSFileManager.defaultManager()
        let imageFolderPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let imageData: NSData = UIImagePNGRepresentation(image)!
        let splitURL = url.componentsSeparatedByString("/")
        let imageName = splitURL[splitURL.count - 1]
        let path = "\(imageFolderPath)/\(imageName)"
        do {
            try fileManager.createDirectoryAtPath(imageFolderPath, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
            print("Failed to create file.")
        }
        print("Creating photo: \(imageName)")
        fileManager.createFileAtPath(path, contents: imageData, attributes: nil)
        CoreDataCreator.save()
    }
}