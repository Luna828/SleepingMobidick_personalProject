import Foundation
import UIKit

class TableViewNameCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    //셀이 랜더링 될 때
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("TableViewNameCell - awakeFromNib() called")
    }
}
