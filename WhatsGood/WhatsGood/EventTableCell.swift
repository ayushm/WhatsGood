//
//  CellViewController.swift
//  WhatsGood
//
//  Created by Ameya Khare on 1/17/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import UIKit

class EventTableCell: UITableViewCell {
    @IBOutlet var up : UIButton!
    @IBOutlet var down : UIButton!
    @IBOutlet var title : UILabel!
    @IBOutlet var votes: UILabel!
    @IBOutlet var descrip: UILabel!
    
    var event: EventItem!
    
    func setEvent (event: EventItem) {
        self.event = event
        refresh()
    }
    
    private func refresh () {
        self.title.text = self.event.title
        self.votes.text = String(self.event.upVotes)
        self.descrip.text = self.event.desc
    }
    
    @IBAction func upVote(sender: AnyObject) {
        NSLog("upvote pressed")
        self.event.upVote()
    }
    
    @IBAction func downVote(sender: AnyObject) {
        NSLog("downvote pressed")
        self.event.downVote()
    }
}