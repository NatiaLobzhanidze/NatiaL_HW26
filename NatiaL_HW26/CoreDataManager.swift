//
//  CoreDataManager.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 27.08.22.
//

import Foundation
import UIKit
import CoreData

protocol ViewContextProvider: AnyObject {
    var viewContext: NSManagedObjectContext { get }
}
extension ViewContextProvider {
    var viewContext: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}
protocol CoreDataManagerProtocol: ViewContextProvider {
    func create(newNote: String, toEntity: String,   array: inout [String])
    func getFetchedDatas(completion: @escaping ([String]) -> (Void))
}

final class CoreDataManager: ViewContextProvider {
    
    // MARK: CREATE
    
    func create(newNote: String, toEntity: String,   array: inout [Note]) {
        
        guard  let entity = NSEntityDescription.entity(forEntityName: toEntity,
                                                       in: viewContext) else { return }
        let noteObj = NSManagedObject(entity: entity,
                                      insertInto: viewContext)
        noteObj.setValue(newNote, forKeyPath: "note")
        noteObj.setValue(false, forKey: "isFavorite")
        
        do {
            try viewContext.save()
            if let noteObj = noteObj as? Note {
                array.insert(noteObj, at: 0)
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: FETCH
    func getFetchedDatas(completion: @escaping ([Note]) -> (Void)) {
        
        var strArr = [Note]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
       
        do {
            let fetchedElements = try viewContext.fetch(fetchRequest)
            for element in fetchedElements {
                if let elemet = element as? Note {
                    strArr.append(elemet)
                }
            }
            completion(strArr)
        }  catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: DELETE
    func deleteData(fromEntity: String, elementDescription: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "note = %@", elementDescription)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
          try viewContext.execute(deleteRequest)
           try viewContext.save()
            print("delete")
        } catch let error as NSError {
          print("Could not delete the data. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: UPDATE
    
    func updateValueOf(objectName: String, by newName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "note = %@", objectName)
        do {
            let obj = try viewContext.fetch(fetchRequest)
            let objUpdate = obj[0] as? NSManagedObject
            objUpdate?.setValue(newName, forKey: "note")
            try viewContext.save()
            
        } catch {
            print("Could not update data. \(error)")
        }
        
    }
    
    func isFavorite(the note: String, value: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "note = %@", note)
        do {
            let obj = try viewContext.fetch(fetchRequest)
            let objUpdate = obj[0] as? NSManagedObject
            objUpdate?.setValue(value, forKey: "isFavorite")
            try viewContext.save()
            
        } catch {
            print("Could not update data. \(error)")
        }
    }
    
    //MARK: FETCH FAV NOTES
    
    func getFavoriteNotes(completion: @escaping ([String]) -> (Void)) {
        var strArr = [String]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        do {
            let fetchedElements = try viewContext.fetch(fetchRequest)
            for element in fetchedElements {
                if let elemet = element as? Note {
                    strArr.append(elemet.note!)
                }
            }
            completion(strArr)
        }  catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
}



