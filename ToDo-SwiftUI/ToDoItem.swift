//
//  ToDoItem.swift
//  ToDo-SwiftUI
//
//  Created by Przemysław Budziszewski on 15/08/2019.
//  Copyright © 2019 Przemysław Budziszewski. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem:NSManagedObject, Identifiable {
    @NSManaged public var createdAt: Date?
    @NSManaged public var title:String?
}

extension ToDoItem {
    static func getAllToDoItems() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
        
        
    }
}
