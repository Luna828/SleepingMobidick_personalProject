//
//  movieTableViewCell.swift
//  API_Project
//
//  Created by t2023-m0050 on 2023/08/10.
//

import UIKit

class movieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImg: UIImageView!
    
    
    @IBOutlet weak var movieTitle: UILabel!
    
    
    @IBOutlet weak var voteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
