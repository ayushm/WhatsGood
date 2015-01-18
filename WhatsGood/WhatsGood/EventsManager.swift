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
        unarchiveSavedItems()
    }
    
    func reloadEvents () {
        events = [EventItem]() // reloads the stupid way currently
        
        var query = PFQuery(className: "Post")
        var eventObjs = query.findObjects()
        
        for event in eventObjs {
            events.append(EventItem(values: event as PFObject))
        }
    }
    
    lazy private var archivePath: String = { // creates a path to save data
        let fileManager = NSFileManager.defaultManager()
        let documentDirectoryURLs = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) as [NSURL]
        let archiveURL = documentDirectoryURLs.first!.URLByAppendingPathComponent("VotedEventIds", isDirectory: false)
        return archiveURL.path!
        }()
    
    func save() {
        var votedOn = [String: Int]() // put time based loading here too
        for event in events {
            if event.vote != -1 {
                votedOn[event.id] = event.vote
                NSLog("was voted on")
            }
        }
        
        NSKeyedArchiver.archiveRootObject(votedOn, toFile: archivePath)
    }
    
    private func unarchiveSavedItems() {
        if NSFileManager.defaultManager().fileExistsAtPath(archivePath) {
            let votedOn = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath) as [String: Int]
            
            for (id, voteVal) in votedOn {
                for event in events {
                    if id == event.id {
                        event.vote = voteVal
                    }
                }
            }
        }
    }
}