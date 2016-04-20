//
//  SettingsViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/24/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var settings: Settings!
    var tableController: SetTableViewController!
    
    @IBOutlet var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        settings = SettingsManager.loadSettings()
        tableController = SetTableViewController(tableView: settingsTableView, settings: settings)
    }
}