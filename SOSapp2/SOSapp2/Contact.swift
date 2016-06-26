//
//  Contact.swift
//  SOSapp2
//
//  Created by faizan on 16/06/16.
//  Copyright © 2016 faizan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Contact)
class Contact: NSManagedObject
{

// Insert code here to add functionality to your managed object subclass
    
    static func getContact () -> [Contact]? {
        
        // Fetch the contacts from persistent data store
        var cntct = [Contact]?()
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate!.managedObjectContext
        let request = NSFetchRequest(entityName: "Contact")
        do {
            try cntct = (context.executeFetchRequest(request)  as? [Contact])!
        }
        catch {
            
        }
        
        return cntct
        
    }
}

