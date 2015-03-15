import UIKit

class CategoryListTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    var name: String {
        get { return nameLabel.text! }
        set { nameLabel?.text = newValue }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
