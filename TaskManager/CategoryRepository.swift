import Foundation
import CoreData

class CategoryRepository {
    
    class func all() -> [Category] {
        println("CategoryRepository#all")

        let objectContext = AppDelegate.instance().managedObjectContext!
        let entityDiscription = NSEntityDescription.entityForName("Category", inManagedObjectContext: objectContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDiscription
        
        var results = objectContext.executeFetchRequest(fetchRequest, error: nil)
        
        return results!.map {
            $0 as Category
        }
    }
    
    class func newCategory(name: String) -> Category {
        println("CategoryRepository#newCategory")

        let objectContext = AppDelegate.instance().managedObjectContext!
        let newCategory = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: objectContext) as Category

        newCategory.name = name
        AppDelegate.instance().saveContext()
        
        return newCategory
    }
    
}
