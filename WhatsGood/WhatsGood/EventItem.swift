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
    var vote: Int // -1 for not voted, 0 for downvote, 1 for upvote
    
    init (values: PFObject) { // takes the PFObject returned by parse
        self.id = values.valueForKey("objectId") as String
        self.title = values["Title"] as String
        self.desc = values["Description"] as String
        self.upVotes = values["Upvotes"] as Int
        self.downVotes = values["Downvotes"] as Int
        // self.location = values["Location"] as PFGeoPoint
        self.startTime = values["startTime"] as NSDate
        // self.endTime = values["endTime"] as Date
        self.vote = -1
    }
    
    func refresh () { // takes an int 1 = upvote, 0 = downvote
        var query = PFQuery(className:"Post")
        query.getObjectInBackgroundWithId(self.id) {
            (event: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            } else {
                event["Upvotes"] = self.upVotes
                event["Downvotes"] = self.downVotes
            }
                
            event.saveInBackgroundWithTarget(nil, selector: nil)
        }
    }
}