//
//  DownloadAction.swift
//  Netdek
//
//  Created by Jason Baird on 11/15/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation

protocol DownloadAction {
    
    func finishDownload(url: String, object: AnyObject, target: AnyObject?)
    
}