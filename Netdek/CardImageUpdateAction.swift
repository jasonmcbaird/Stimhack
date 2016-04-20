//
//  CardImageDownloadAction.swift
//  Netdek
//
//  Created by Jason Baird on 11/17/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class CardImageUpdateAction: DownloadAction {
    
    var imageView: UIImageView
    
    init(imageView: UIImageView) {
        self.imageView = imageView
    }
    
    func finishDownload(url: String, object: AnyObject, target: AnyObject?) {
        CardImageSaveAction().finishDownload(url, object: object, target: target)
        imageView.image = object as? UIImage
        imageView.hidden = false
        imageView.superview!.hidden = false
        let spinners: [UIView] = imageView.superview!.subviews.filter({$0 is UIActivityIndicatorView})
        for spinner in spinners {
            spinner.hidden = true
        }
        print("Displaying image for \((target as! Card).name)")
    }
}