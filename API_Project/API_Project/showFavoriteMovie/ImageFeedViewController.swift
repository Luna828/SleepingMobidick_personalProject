import UIKit
import Kingfisher

class ImageFeedViewController: UIViewController {
    let sectionInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    var movieData: [(title: String, average: Double, posterPath: String)] = []

    @IBOutlet weak var imageCollectionView: UICollectionView!
    var array: [FotoModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = FotoAPIInput(limit: 10, page: 1)
        FotoDataManager().fotoDataManager(input, self)
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(UINib(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCollectionViewCell")
        imageCollectionView.contentInset = sectionInsets

    }
}

extension ImageFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as! FeedCollectionViewCell
        
//        let movie = movieData[indexPath.item]
//        cell.movieTitle.text = movie.title
//        cell.averageVote.text = String(movie.average)
        
        //let movie = movieData[indexPath.item]
        if let urlString = array[indexPath.row].url {
            let url = URL(string: urlString)
            cell.imageViewFeed.kf.setImage(with: url)
        }
        
        cell.movieTitle.text = "연습"
        cell.averageVote.text = "10"

        return cell
    }
}

extension ImageFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let itemSpacing: CGFloat = 1
        let cellWidth: CGFloat = (width - (sectionInsets.left + sectionInsets.right) - (itemSpacing * 2)) / 3

        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension ImageFeedViewController {
    func successAPI(_ result: [FotoModel]) {
        array = result
        imageCollectionView.reloadData()
    }
}
