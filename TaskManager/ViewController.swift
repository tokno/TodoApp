import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories: [Category] {
        return CategoryRepository.all()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nil {
            return
        }
        
        switch segue.identifier! {
        case "showTaskList":
            let listViewController = segue.destinationViewController as TaskListViewController
            let cell = sender as UITableViewCell
            let path = categoryTableView.indexPathForCell(cell)
            let selectedCategory = categories[path!.row]

            listViewController.category = selectedCategory
        default:
            return
        }
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as CategoryListTableCell
        
        cell.name = categories[indexPath.item].name
        return cell
    }
    
}
