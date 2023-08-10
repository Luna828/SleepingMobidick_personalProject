import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let IMG_URL = "https://image.tmdb.org/t/p/w500/"
    
    let logo = UIImageView()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let button = UIButton(type: .system)
    var movieData: [(title: String, average: Double, posterPath: String)] = []
    
    var totalList: [(title: String, average: Double, posterPath: String)] = []

    @objc func sortButtonClicked() {
        if button.titleLabel?.text == "평점순" {
            movieData.sort{ $0.average > $1.average }
            button.setTitle("알파벳순", for: .normal)
            print(movieData)
        } else {
            movieData.sort{ $0.title < $1.title }
            button.setTitle("평점순", for: .normal)
        }
       
        tableView.reloadData()
    }
    
    @objc func sort_prac(){
        if button.titleLabel?.text == "평점순" {
            movieData.sort{ $0.average > $1.average }
            button.setTitle("전체목록순", for: .normal)
            print(movieData)
        } else {
            movieData = totalList
            button.setTitle("평점순", for: .normal)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logo)
        view.addSubview(searchBar)
        view.addSubview(button)
        view.addSubview(tableView)
        
        logo.backgroundColor = .white
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logo.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        searchBar.placeholder = "영화제목을 입력해주세요"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        button.setTitle("평점순", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        button.addTarget(self, action: #selector(sort_prac), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        APIManager.fetch { [weak self] (titles, average, posterPath) in
            print("posterPath: \(posterPath!)")

            DispatchQueue.main.async { [self] in
                if let titles = titles, let average = average, let posterPath = posterPath {
                    for index in 0..<titles.count {
                        self?.movieData.append((titles[index], average[index], posterPath[index]))
                        print("===========posterPath: \(posterPath[index])")
                    }
                }
                self?.totalList.append(contentsOf: self?.movieData ?? [])
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        if indexPath.row < movieData.count {
            let data = movieData[indexPath.row]
            cell.ImageView.image = UIImage(named: "\(IMG_URL)\(data.posterPath)")
            //cell.ImageView = UIImageView(image: UIImage(systemName: "house"))
            cell.movieTitle.text = data.title
            cell.voteAverage.text = String(data.average)
            
            print("111111111111\(cell.ImageView)")
        }
        return cell
    }
}


