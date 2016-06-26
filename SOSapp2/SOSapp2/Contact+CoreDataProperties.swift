//
//  Contact+CoreDataProperties.swift
//  SOSapp2
//
//  Created by faizan on 16/06/16.
//  Copyright © 2016 faizan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var name: String?
    @NSManaged var number: String?

}
