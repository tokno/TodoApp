import Foundation
import CoreData

class TaskRepository {

    class func all() -> [Task] {
        println("TaskRepository#all")
        
        let objectContext = AppDelegate.instance().managedObjectContext!
        let entityDiscription = NSEntityDescription.entityForName("Task", inManagedObjectContext: objectContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDiscription
        
        var results = objectContext.executeFetchRequest(fetchRequest, error: nil)
        
        return results!.map {
            $0 as Task
        }
    }
    
    class func newTask(name: String, _ category: Category) -> Task {
        println("TaskRepository#newTask")

        let objectContext = AppDelegate.instance().managedObjectContext!
        let task = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: objectContext) as Task

        task.name = name
        task.category = category
        category.tasks.setByAddingObject(task)
        
        objectContext.save(nil)
        
        return task
    }
    
    class func save(task: Task) {
        AppDelegate.instance().saveContext()
    }

}
