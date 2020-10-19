//
//  DatabaseManager.swift
//  Drawer
//
//  Created by Kyle on 10/19/20.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    static let shareInstance = DatabaseManager()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveObject(data: Data, entityName: String) {
        let entity =
          NSEntityDescription.entity(forEntityName: entityName,
                                     in: managedContext)!
        
        let newObject = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        newObject.setValue(title, forKeyPath: "title")
        
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    
}
