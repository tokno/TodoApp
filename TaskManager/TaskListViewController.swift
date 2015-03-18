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
    
    override func viewWillAppear(animated: Bool) {
        println("viewWillAppear")
        self.becomeFirstResponder()
        taskTable.reloadData()
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        println("unwind")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nil {
            return
        }
        
        println(segue.identifier)
        
        switch segue.identifier! {
        case "createNewTask":
            let controller = segue.destinationViewController as CreateTaskViewController
            controller.category = category
        default:
            return
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        switch motion {
        case .MotionShake:
            println("Shake gusture detected.")
            deleteDoneTasks()
        default:
            println()
        }
    }
    
    func deleteDoneTasks() {
        let tasks: [Task] = category.tasks.allObjects.map {
            $0 as Task
        }
        
        let doneTasks = tasks.filter { (task: Task) in
            task.completeStatus == .Completed
        }
        
        TaskRepository.delete(doneTasks)
        taskTable.reloadData()
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
        
        // 完了・未完了の切り替え
        switch task.completeStatus {
        case .Completed:
            task.uncomplete()
        case .Uncompleted:
            task.complete(NSDate())
        }
        
        task.save()
        
        cell.showAs(task.completeStatus)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TaskListTableCell
        let task = cell.task!
        
        TaskRepository.delete(task)
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
    
}
