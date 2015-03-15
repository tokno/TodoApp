import UIKit
import CoreData

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var category: Category!
    @IBOutlet weak var taskTable: UITableView!
        
    var objectContext: NSManagedObjectContext {
        let appDelegate = AppDelegate.instance()
        return appDelegate.managedObjectContext!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category.name
        
        taskTable.delegate = self
        taskTable.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        self.reloadInputViews()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nil {
            return
        }
        
        switch segue.identifier! {
        case "createNewTask":
            let controller = segue.destinationViewController as CreateTaskViewController
            controller.category = category
        default:
            return
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskView") as TaskListTableCell
        cell.task = category.tasks.allObjects[indexPath.item] as? Task

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TaskListTableCell
        let task = cell.task!
        
        switch task.completeStatus {
        case .Completed:
            task.uncomplete()
        case .Uncompleted:
            task.complete(NSDate())
        }
        
        cell.showAs(task.completeStatus)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // TODO 削除実装後trueに
        return false
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // TODO 削除処理実装
        println("Delete")
    }

}
