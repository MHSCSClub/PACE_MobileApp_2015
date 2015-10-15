//
//  MainData.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/6/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import Foundation
import CoreData

class MainData: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var evtid: NSNumber
    @NSManaged var time: NSDate
    @NSManaged var type: String
    @NSManaged var descrition: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, evtid: NSNumber, time: NSDate, type: String, descrition: String, Title: String) -> MainData {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("MainData", inManagedObjectContext: moc) as! MainData
        newItem.evtid = evtid
        newItem.time = time
        newItem.type = type
        newItem.descrition = descrition
        newItem.title = Title
        return newItem
    }

}
