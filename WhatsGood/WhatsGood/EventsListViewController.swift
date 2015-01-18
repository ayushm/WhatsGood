//
//  EventsListViewController.swift
//  WhatsGood
//
//  Created by Ameya Khare on 1/17/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import UIKit

class EventsListViewController: UITableViewController {
    var eventsList = EventsManager()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventsListCell", forIndexPath: indexPath) as EventTableCell
        cell.event = eventsList.events[indexPath.row]
        cell.reference = self.tableView
        
        for event in eventsList.events {
            if event.id == cell.event.id {
                event.upVotes = cell.event.upVotes
                event.downVotes = cell.event.downVotes
            }
        }
        
        eventsList.save()
        cell.refresh()
        
        return cell
    }
}
