import Foundation
import CoreData

class Category: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var tasks: NSSet
    
    override var description: String {
        get {
            return "name:\(name)"
        }
    }
}
