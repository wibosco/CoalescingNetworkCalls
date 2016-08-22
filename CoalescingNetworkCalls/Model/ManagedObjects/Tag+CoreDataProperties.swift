//
//  Tag+CoreDataProperties.swift
//  CoalescingNetworkCalls
//
//  Created by Boles on 22/08/2016.
//  Copyright © 2016 Boles. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tag {

    @NSManaged var name: String?
    @NSManaged var questions: NSSet?

}
