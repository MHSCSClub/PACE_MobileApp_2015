//
//  Flashcards.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/11/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import Foundation
import CoreData

class Flashcards: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var fcid: NSNumber
    @NSManaged var info: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, fcid: Int, info: String) -> Flashcards {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Flashcards", inManagedObjectContext: moc) as! Flashcards
        newItem.name = name
        newItem.fcid = fcid
        newItem.info = info
        return newItem
    }

}
