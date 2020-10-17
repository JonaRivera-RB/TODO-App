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
}
