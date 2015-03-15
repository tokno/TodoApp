import UIKit
import CoreData

class CreateCategoryViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createCategoryAndExit(sender: AnyObject) {
        if nameField.text.isEmpty {
            return
        }
        
        CategoryRepository.newCategory(nameField.text)
        
        performSegueWithIdentifier("finishCategoryCreation", sender: self)
    }
    
}
