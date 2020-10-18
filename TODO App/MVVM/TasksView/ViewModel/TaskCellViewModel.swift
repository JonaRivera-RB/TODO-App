//
//  TaskCellViewModel.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 18/10/20.
//  Copyright © 2020 Jonathan Rivera. All rights reserved.
//

import Foundation
import UIKit

struct TaskCellViewModel {
    
    var task: TASK
    
    init(task: TASK) {
        self.task = task
    }
    
    var doneButtonBackgroundColor: UIColor {
        return task.taskCompletion ? .red : .white
    }
    
    var description: String {
        return task.taskDescription ?? ""
    }
    
    var date: String {
        return task.taskDate ?? ""
    }
    
    var isHiddenBackgroundView: Bool {
        return task.taskCompletion ? false : true
    }
}
