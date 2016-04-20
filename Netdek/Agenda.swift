//
//  Agenda.swift
//  Netdek
//
//  Created by Jason Baird on 11/14/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import CoreData

@objc(Agenda)
public class Agenda: CardType {
    
    @NSManaged var agendaPoints: Int16
    
    override func setTypeTraits(dictionary: [String: AnyObject]) {
        agendaPoints = getInt16Value("agendapoints", dictionary: dictionary)
    }
    
    override func getTypeTraits() -> [String: AnyObject] {
        return ["Agenda Points": Int(agendaPoints)]
    }
    
}