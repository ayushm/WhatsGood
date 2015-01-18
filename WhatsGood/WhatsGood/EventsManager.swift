//
//  EventsManager.swift
//  WhatsGood
//
//  Created by Ameya Khare on 1/17/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import Foundation
import Parse

class EventsManager {
    var events = [EventItem]()
    
    init () {
        Parse.enableLocalDatastore();
        Parse.setApplicationId("dnzQeib9hrrvYIGRXJ9XfWyHklR9fdfzVR2p8l0T",
            clientKey:"Tsz6FxLNyR1cjX0PCT7abRLRtLbXP0gx4YsCW09c");
        reloadEvents()
    }
    
    func reloadEvents () {
        events = [EventItem]() // reloads the stupid way currently
        
        var query = PFQuery(className: "Post")
        var eventObjs = query.findObjects()
        
        for event in eventObjs {
            events.append(EventItem(values: event as PFObject))
        }
    }
}