//
//  ContactsTableViewController.swift
//  SOSapp2
//
//  Created by faizan on 15/06/16.
//  Copyright © 2016 faizan. All rights reserved.
//

import UIKit
import CoreData


class ContactsTableViewController: UITableViewController
{
    var contacts = [Contact]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // show toolbar in tableview
        self.navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBAction func addNewContact(sender: AnyObject) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    override func viewWillAppear(animated: Bool) {
        
        contacts = Contact.getContact()!
        self.tableView.reloadData()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
             self.navigationController?.setToolbarHidden(true, animated: true)
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath)
        // Configure the cell...
        let contact: NSManagedObject = (contacts[indexPath.row])
        cell.textLabel?.text = contact.valueForKey("name") as? String
        cell.detailTextLabel?.text = contact.valueForKey("number") as? String
        if contacts.count > 1 {
            addButton.enabled = false
        }
        return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // get th eapp delegate
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            // delete objecct from data
            let contct = contacts[indexPath.row]
            contacts.removeAtIndex(indexPath.row)
            context?.deleteObject(contct)
            do {
                try context?.save()
            }
            catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            if contacts.count < 2 {
                addButton.enabled = true
            }
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "IdentifierEdit" {
            
             let indexPath = self.tableView.indexPathForSelectedRow
            let destViewController = segue.destinationViewController as? AddContactsViewController
            destViewController?.newContact = contacts[indexPath!.row]
        }
        
    }
    

}
