import UIKit

class MovieTableViewCell: UITableViewCell {
    var ImageView = UIImageView()
    let movieTitle = UILabel()
    let voteAverage = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        ImageView.image = UIImage(systemName: "video")
        ImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        ImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ImageView.contentMode = .scaleAspectFit
        horizontalStackView.addArrangedSubview(ImageView)
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        movieTitle.textColor = .black
        verticalStackView.addArrangedSubview(movieTitle)
        
        voteAverage.textColor = .gray
        voteAverage.font = UIFont.systemFont(ofSize: 13)
        verticalStackView.addArrangedSubview(voteAverage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
