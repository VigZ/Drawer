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
            // Should add saftey check to see if object has the property i am trying to set.
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
    
    func deleteObject(object:NSManagedObject){
        managedContext.delete(object)
        
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateObject(identifier: String, dataMap: [String:Any], entityDescription: String) {

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityDescription)
        
        let predicate = NSPredicate(format: "name = '\(identifier)'")
        fetchRequest.predicate = predicate
        do
        {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1
            {
                let objectUpdate = object.first as! NSManagedObject
                
                for (key,value) in dataMap {
                    // Should add saftey check to see if object has the property i am trying to set.
                    objectUpdate.setValue(value, forKeyPath: key)
                }
                do{
                    try managedContext.save()
                }
                catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
        catch
        {
            print(error)
        }
    }
    
}
