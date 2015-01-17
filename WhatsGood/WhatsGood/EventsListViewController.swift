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
        let cell = tableView.dequeueReusableCellWithIdentifier("EventsListCell", forIndexPath: indexPath) as UITableViewCell
        let event = eventsList.events[indexPath.row]
        
        //cell.textLabel!.text = event.title will overwrite the title of the cell, and run over random shit
        
        return cell
    }
}
