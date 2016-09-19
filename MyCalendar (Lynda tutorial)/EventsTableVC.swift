//
//  EventsTableVC.swift
//  MyCalendar (Lynda tutorial)
//
//  Created by Adam Voight on 2016-09-07.
//  Copyright © 2016 Adam Voight. All rights reserved.
//

import Foundation
import UIKit

class EventsTableVC : UITableViewController{
    
    
    
    var monthNumber : Int = -1
    var dayNumber : Int = -1
    //var events : [String] = Array()
    var events : [AnyObject] = Array() // for loading CalandarEvents
    
    override func viewDidLoad() {
        print("\(monthNumber)-\(dayNumber)")
    }
    
    @IBAction func addButtonPressed(sender : UIBarButtonItem){
        let newEvent = "Test Event \(events.count + 1)"
        
        let defaultsKey = "\(monthNumber)-\(dayNumber)"
        let ce = CalendarEvent(withTitle: newEvent, andDateString: defaultsKey)
        
        let encodedCE = NSKeyedArchiver.archivedDataWithRootObject(ce)
        events.append(encodedCE)
        
        NSUserDefaults.standardUserDefaults().setObject(events, forKey: defaultsKey)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        //events.append(newEvent)
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(
        tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
        
            if (editingStyle == UITableViewCellEditingStyle.Delete){
                self.events.removeAtIndex(indexPath.row)
                
                let sections = NSIndexSet(index: 0)
                tableView.reloadSections(sections, withRowAnimation: .Fade)
                
            }
    }
    
    //How many sections?
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //How many rows in each section?
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaultsKey = "\(monthNumber)-\(dayNumber)"
        
        let arrayOfEvents = NSUserDefaults.standardUserDefaults().arrayForKey(defaultsKey)
        
        if let arrayOfEvents = arrayOfEvents{
            events = arrayOfEvents
        }
        
        return events.count
    }
    
    //Return cell for display
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
                //cell.textLabel?.text = events[indexPath.row]
        
        if let eventObject = events[indexPath.row] as? NSData{
            let ce = NSKeyedUnarchiver.unarchiveObjectWithData(eventObject) as! CalendarEvent
            cell.textLabel?.text = ce.title
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EventsEventSegue"){
            let selectedRow = tableView.indexPathForSelectedRow?.row
            
            if let dest = segue.destinationViewController as? EventVC{
                dest.title = "\(selectedRow! + 1)"
                //dest.eventNumber = eventNumber
            }
        }
    }

}


    

