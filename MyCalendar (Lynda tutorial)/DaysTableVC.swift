//
//  DaysTableVC.swift
//  MyCalendar (Lynda tutorial)
//
//  Created by Adam Voight on 2016-09-07.
//  Copyright © 2016 Adam Voight. All rights reserved.
//

import Foundation
import UIKit

class DaysTableVC : UITableViewController{
    //How many sections?
    
    
    var monthNumber = -1
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //How many rows in each section?
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 31
            }
    
    //Return cell for display
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
        
        
        //This method returns an optional value. But, I'm confident that I've set everything up correctly,
        // so I'm going to use an ! to implicitly unwrap the optional value. In your app, you may want to
        //adopt a more robust solution for checking to make sure that you got a cell back here.
        
        cell.textLabel?.text = "\(indexPath.row + 1)"
        
        return cell
        
    }

    
    
}

