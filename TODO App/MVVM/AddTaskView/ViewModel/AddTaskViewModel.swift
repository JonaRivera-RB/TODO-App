//
//  TaskViewModel.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 18/10/20.
//  Copyright © 2020 Jonathan Rivera. All rights reserved.
//

import Foundation

class AddTaskViewModel {
    
    var task: Task?
    
    var refreshData = { (success: Bool) -> () in }
    
    private var taskSavedCorrectly: Bool = Bool() {
        didSet {
            refreshData(taskSavedCorrectly)
        }
    }
    
    func addTask(task: Task) {
        self.task = task
    }
    
    func saveTask() {
        guard let task = task else { return }
        TODO.shared.saveTask(task: task) { success in
            DispatchQueue.main.async {
                self.taskSavedCorrectly = success
            }
        }
    }
}
