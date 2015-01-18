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
        let event = eventsList.events[indexPath.row]
        
        //set attributes right here
        eventsList.reloadEvents()
        cell.setEvent(event, ref: self.tableView)
        
        NSLog("at least it refreshed! bb")
        
        return cell
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("sup")
        
        eventsList.reloadEvents()
        self.tableView.reloadData()
    }*/
}
