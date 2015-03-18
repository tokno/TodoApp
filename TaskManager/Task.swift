import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var done_at: NSDate?
    @NSManaged var category: NSManagedObject
    
    override var description: String {
        get {
            return "name:\(name) category:\(category)"
        }
    }
    
    func complete(time: NSDate) {
        done_at = time
    }
    
    func uncomplete() {
        done_at = nil
    }
    
    var completeStatus: State {
        return (done_at != nil) ? .Completed : .Uncompleted
    }
    
    func save() {
        TaskRepository.save(self)
    }
    
    enum State {
        case Completed
        case Uncompleted
    }
}
