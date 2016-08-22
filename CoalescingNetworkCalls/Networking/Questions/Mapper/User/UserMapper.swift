//
//  UserParser.swift
//  CoalescingNetworkCalls
//
//  Created by William Boles on 14/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import CoreData
import CoreDataServices

class UserMapper: Mapper {

    //MARK: - User
    
    func mapUser(userResponse: Dictionary<String, AnyObject>) -> User {
        let userID = userResponse["user_id"] as! NSInteger
        
        let predicate = NSPredicate(format: "userID == \(userID)")
        
        var user = self.localManagedObjectContext.retrieveFirstEntry(User.self, predicate: predicate) as? User
        
        if (user == nil) {
            user = NSEntityDescription.insertNewObjectForEntity(User.self, managedObjectContext: self.localManagedObjectContext) as? User
            
            user?.userID = userID
        }
        
        /*----------------*/
        
        user?.name = userResponse["display_name"] as? String
        
        /*----------------*/
        
        return user!
    }
}
