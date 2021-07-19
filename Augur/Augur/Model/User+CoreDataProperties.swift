//
//  User+CoreDataProperties.swift
//  Augur
//
//  Created by Andrew Gillis on 7/18/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var points: Int64
    @NSManaged public var instanceURL: String?

}

extension User : Identifiable {

}
