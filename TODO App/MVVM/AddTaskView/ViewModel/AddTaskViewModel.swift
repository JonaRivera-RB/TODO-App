//
//  TaskViewModel.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 18/10/20.
//  Copyright © 2020 Jonathan Rivera. All rights reserved.
//

import Foundation

class AddTaskViewModel {
    
    var refreshData = { (success: Bool) -> () in }
    
    private var taskSavedCorrectly: Bool = Bool() {
        didSet {
            refreshData(taskSavedCorrectly)
        }
    }
    
    func saveTask(task: Task) {
        TODO.shared.saveTask(task: task) { success in
            DispatchQueue.main.async {
                self.taskSavedCorrectly = success
            }
        }
    }
    
    func updateTask(oldTask: TASK?, task: Task) {
        guard let oldTask = oldTask else { return }
        TODO.shared.updateTask(oldTask: oldTask, task: task) { success in
            DispatchQueue.main.async {
                self.taskSavedCorrectly = success
            }
        }
    }
}
