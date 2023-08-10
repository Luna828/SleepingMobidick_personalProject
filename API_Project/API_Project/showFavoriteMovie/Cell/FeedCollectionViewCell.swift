import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewFeed: UIImageView!

    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var averageVote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
