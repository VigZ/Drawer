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
    
    func saveObject(dataMap: [String:Any], entityDescription: String) {
        let entity =
            NSEntityDescription.entity(forEntityName: entityDescription,
                                     in: managedContext)!
        
        let newObject = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        for (key,value) in dataMap {
            newObject.setValue(value, forKeyPath: key)
        }
        
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    
    func fetchObjects(entityDescription: String) -> [NSManagedObject]{
         
         let fetchRequest =
           NSFetchRequest<NSManagedObject>(entityName: entityDescription)
         
         do {
            return try managedContext.fetch(fetchRequest)
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
        return []
    }
    
}
