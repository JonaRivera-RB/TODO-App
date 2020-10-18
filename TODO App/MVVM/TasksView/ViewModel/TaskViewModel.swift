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
    
    var tasks: [[TASK]] = [] {
        didSet {
            refreshData()
        }
    }
    
    var sectionTaskName: [String] = ["TODO","DONE"]
    
    private var taskCompleted: [TASK] = []
    private var taskNotCompleted: [TASK] = []
    
    var shouldHiddenTableView: Bool {
        return tasks.count > 0 ? false : true
    }
    
    func retriveTasksList() {
        TODO.shared.fetch { _, tasks in
            DispatchQueue.main.async {
                if let tasks = tasks {
                    
                    self.taskCompleted.removeAll()
                    self.taskNotCompleted.removeAll()
                    self.tasks.removeAll()
                    
                    for _task in tasks {
                        if _task.taskCompletion {
                            self.taskCompleted.append(_task)
                        }else {
                            self.taskNotCompleted.append(_task)
                        }
                    }
                    
                    self.tasks.append(self.taskNotCompleted.sorted(by:  { self.dateFormatterForTask().date(from: $0.taskDate ?? "")! < self.dateFormatterForTask().date(from: $1.taskDate ?? "")! }))
                    
                    self.tasks.append(self.taskCompleted.sorted(by:  { self.dateFormatterForTask().date(from: $0.taskDate ?? "")! < self.dateFormatterForTask().date(from: $1.taskDate ?? "")! }))
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
    
    func dateFormatterForTask() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        return dateFormatter
    }
}
