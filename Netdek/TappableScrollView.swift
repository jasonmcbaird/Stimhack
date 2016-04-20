//
//  TappableScrollView.swift
//  Netdek
//
//  Created by Jason Baird on 11/23/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class TappableScrollView: UIScrollView {
    
    var controller: VisualDeckViewController!
    
    func tapImageView(sender: UITapGestureRecognizer) {
        if let imageView = sender.view! as? UIImageView {
            for column in controller.columns {
                if(column.contains(imageView)) {
                    controller.bringToFront(column, index: column.indexOf(imageView)!)
                }
            }
        }
    }
    
}