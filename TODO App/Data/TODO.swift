//
//  TODO.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 17/10/20.
//  Copyright © 2020 Jonathan Rivera. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

struct TODO {
    
    static let shared = TODO()
//    func removeGoal(atIndexPath indexPath: IndexPath) {
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
//
//        managedContext.delete(goals[indexPath.row])
//
//        do {
//            try managedContext.save()
//            print("Successfully removed goal!")
//        } catch {
//            debugPrint("Could not remove: \(error.localizedDescription)")
//        }
//    }
    
    func fetch(completion: (_ complete: Bool,_ task: [TASK]?) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<TASK>(entityName: "TASK")
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true, tasks)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false, nil)
        }
    }
    
    func saveTask(task: Task, completion:(_ completion: Bool) -> () ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let taskDatabase = TASK(context: managedContext)
        
        taskDatabase.taskDescription = task.taskDescription
        taskDatabase.taskDate = task.taskDate
        taskDatabase.taskCompletion = task.taskCompleted
        
        do {
            try managedContext.save()
            print("successfully saved task")
            completion(true)
        } catch {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
    }
}
