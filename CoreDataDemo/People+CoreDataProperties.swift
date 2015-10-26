//
//  People+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by 李刚 on 15/10/23.
//  Copyright © 2015年 李刚. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension People {

    @NSManaged var name: String?
    @NSManaged var age: Int16

}
