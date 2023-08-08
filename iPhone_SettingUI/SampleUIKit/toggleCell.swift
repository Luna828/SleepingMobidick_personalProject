import UIKit

class toggleCell: UITableViewCell {
    
    @IBOutlet weak var toggleImg: UIImageView!
    @IBOutlet weak var toggleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("toggleCell - awakeFromNib() called")
    }
}


