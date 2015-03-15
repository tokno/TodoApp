import Foundation
import UIKit

class TaskListTableCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!

    var task: Task? {
        didSet {
            println("task.done_at:\(task?.done_at)")
            
            self.show(task!)
        }
    }
    
    func showAs(state: Task.State) {
        switch state {
        case .Completed:
            self.accessoryType = .Checkmark
        case .Uncompleted:
            self.accessoryType = .None
        }
    }
    
    private func show(task: Task) {
        taskNameLabel.text = task.name
        showAs(task.completeStatus)
    }
}
