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
    // var startTime: Date
    // var endTime: Date
    
    init (values: PFObject) {
        /*Parse.enableLocalDatastore();
        Parse.setApplicationId("dnzQeib9hrrvYIGRXJ9XfWyHklR9fdfzVR2p8l0T",
            clientKey:"Tsz6FxLNyR1cjX0PCT7abRLRtLbXP0gx4YsCW09c");*/
        
        self.id = values.valueForKey("objectId") as String
        self.title = values["Title"] as String
        self.desc = values["Description"] as String
        self.upVotes = values["Upvotes"] as Int
        self.downVotes = values["Downvotes"] as Int
        // self.location = values["Location"] as PFGeoPoint
        // self.startTime = values["startTime"] as Date
        // self.endTime = values["endTime"] as Date
    }
    
    func upVote () {
        // check they havent voted yet
        
        // then do this stuff
        var query = PFQuery(className:"Post")
        query.getObjectInBackgroundWithId(self.id) {
            (event: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            } else {
                event["Upvotes"] = self.upVotes + 1
                event["score"] = 1338
                event.saveInBackgroundWithTarget(nil, selector: nil)
            }
        }
    }
    
    func downVote () {
        // check they haven't voted yet
        
    }
}