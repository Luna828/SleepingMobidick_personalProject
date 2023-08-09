import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewFeed: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
