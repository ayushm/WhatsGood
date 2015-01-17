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
    var title: String
    var desc: String
    var upVotes: Int
    var downVotes: Int
    // var location: PFGeoPoint // has latitude, longitude attributes
    // var startTime: Date
    // var endTime: Date
    
    init (values: PFObject) {
        self.title = values["Title"] as String
        self.desc = values["Description"] as String
        self.upVotes = values["Upvotes"] as Int
        self.downVotes = values["Downvotes"] as Int
        // self.location = values["Location"] as PFGeoPoint
        // self.startTime = values["startTime"] as Date
        // self.endTime = values["endTime"] as Date
    }
}