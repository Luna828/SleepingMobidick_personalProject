import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var settingImg: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("SettingCell - awakeFromNib() called")
    }
}
