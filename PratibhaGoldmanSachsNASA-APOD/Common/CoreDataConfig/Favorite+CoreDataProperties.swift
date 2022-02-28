//
//  Favorite+CoreDataProperties.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var title: String?
    @NSManaged public var explanation: String?
    @NSManaged public var date: String?
    @NSManaged public var media_type: String?
    @NSManaged public var mediaURL: String?

}

extension Favorite : Identifiable {

}
