//
//  UserInfo+CoreDataProperties.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/27/22.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var id: String?
    @NSManaged public var tokenExpire: Double
    @NSManaged public var photos: NSSet?

}

// MARK: Generated accessors for photos
extension UserInfo {

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

extension UserInfo : Identifiable {

}
