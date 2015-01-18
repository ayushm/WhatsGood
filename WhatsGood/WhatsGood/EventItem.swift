//
//  EventItem.swift
//  WhatsGood
//
//  Created by Ameya Khare on 1/17/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import Foundation
import Parse

class EventItem: NSObject {
    var id: String
    var title: String
    var desc: String
    var upVotes: Int
    var downVotes: Int
    // var location: PFGeoPoint // has latitude, longitude attributes
    var startTime: NSDate
    // var endTime: Date
    
    init (values: PFObject) { // takes the PFObject returned by parse
        self.id = values.valueForKey("objectId") as String
        self.title = values["Title"] as String
        self.desc = values["Description"] as String
        self.upVotes = values["Upvotes"] as Int
        self.downVotes = values["Downvotes"] as Int
        // self.location = values["Location"] as PFGeoPoint
        self.startTime = values["startTime"] as NSDate
        NSLog(String(format: "%@", startTime))
        // self.endTime = values["endTime"] as Date
        
        var dateFormatter: NSDateFormatter = NSDateFormatter() // HOW TO PRINT THE DATE
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(startTime)
        NSLog(strDate)
    }
    
    func vote (upOrDown: Int) { // takes an int 1 = upvote, 0 = downvote
        var query = PFQuery(className:"Post")
        query.getObjectInBackgroundWithId(self.id) {
            (event: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            } else {
                if upOrDown == 1 {
                    event["Upvotes"] = self.upVotes + 1
                } else {
                    event["Downvotes"] = self.downVotes + 1
                }
                
                event.saveInBackgroundWithTarget(nil, selector: nil)
                NSLog("saved update")
            }
        }
    }
}