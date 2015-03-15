import Foundation
import UIKit

class CreateTaskViewController: UIViewController {
    
    var category: Category!
    
    @IBOutlet weak var naemeField: UITextField!
    
    override func viewDidLoad() {
    }
    
    @IBAction func newTaskAndExit(sender: AnyObject) {
        if (naemeField.text.isEmpty) {
            return
        }
        
        if category == nil {
            println("category is nil")
        }
        
        TaskRepository.newTask(naemeField.text, category)
        
        performSegueWithIdentifier("finishTaskCreation", sender: self)
    }
    
}
