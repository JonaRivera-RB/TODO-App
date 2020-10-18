//
//  tasksViewModel.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 17/10/20.
//  Copyright © 2020 Jonathan Rivera. All rights reserved.
//

import Foundation
import UIKit

class TasksViewModel {
    
    var refreshData = { () -> () in }
    
    var tasks: [TASK] = [] {
        didSet {
            refreshData()
        }
    }
    
    var shouldHiddenTableView: Bool {
        return tasks.count > 0 ? false : true
    }
    
    func retriveTasksList() {
        TODO.shared.fetch { _, tasks in
            DispatchQueue.main.async {
                if let tasks = tasks {
                    self.tasks = tasks
                }
            }
        }
    }
    
    func removeTask(task: TASK) {
        TODO.shared.removeTask(task: task) { _ in
            DispatchQueue.main.async {
                self.retriveTasksList()
            }
        }
    }
    
    func completeTask(task: TASK) {
        TODO.shared.completeTask(task: task) { success in
            DispatchQueue.main.async {
                if success {
                    self.retriveTasksList()
                }
            }
        }
    }
}
