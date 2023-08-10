import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let stackView = UIStackView()
    let imgView = UIImageView()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let button = UIButton(type: .system)
    var movieData: [(title: String, average: Double)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        imgView.backgroundColor = .white
        imgView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        stackView.addArrangedSubview(imgView)
        
        searchBar.placeholder = "Search"
        stackView.addArrangedSubview(searchBar)
        
        button.setTitle("평점순", for: .normal)
        stackView.addArrangedSubview(button)
        
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        //        tableView.register(UINib(nibName: "movieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        stackView.addArrangedSubview(tableView)
        
        APIManager.fetch { [weak self] titles, average in
            DispatchQueue.main.async {
                if let titles = titles, let average = average {
                    self?.movieData = zip(titles, average).map{($0, $1)} //데이터 매칭 저장
                    self?.tableView.reloadData()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30 // Example number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        if indexPath.row < movieData.count {
            let data = movieData[indexPath.row]
            cell.ImageView = UIImageView(image: UIImage(systemName: "house"))
            cell.movieTitle.text = data.title
            cell.voteAverage.text = String(data.average)
            
        }
        return cell
    }
}

class MovieTableViewCell: UITableViewCell {
    var ImageView = UIImageView()
    let movieTitle = UILabel()
    let voteAverage = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        ImageView.backgroundColor = .systemPink
        ImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        ImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        horizontalStackView.addArrangedSubview(ImageView)
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        movieTitle.textColor = .black
        verticalStackView.addArrangedSubview(movieTitle)
        
        voteAverage.textColor = .gray
        verticalStackView.addArrangedSubview(voteAverage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
