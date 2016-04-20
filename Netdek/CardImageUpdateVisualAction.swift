//
//  CardImageUpdateVisualAction.swift
//  Netdek
//
//  Created by Jason Baird on 11/21/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class CardImageUpdateVisualAction: DownloadAction {
    
    var imageViews: [UIImageView]
    
    init(imageViews: [UIImageView]) {
        self.imageViews = imageViews
    }
    
    func finishDownload(url: String, object: AnyObject, target: AnyObject?) {
        CardImageSaveAction().finishDownload(url, object: object, target: target)
        for imageView in imageViews {
            imageView.image = object as? UIImage
        }
        print("Displaying image for \((target as! Card).name)")
    }
    
}