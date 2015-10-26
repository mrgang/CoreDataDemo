//
//  People.swift
//  CoreDataDemo
//
//  Created by 李刚 on 15/10/23.
//  Copyright © 2015年 李刚. All rights reserved.
//

import Foundation
import CoreData


class People: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func getName() -> String {
        return name ?? "NULL"
    }
    func getAge() -> Int16 {
        return age ?? 0
    }
}
