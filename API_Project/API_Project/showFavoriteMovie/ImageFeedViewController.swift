import UIKit

class ImageFeedViewController: UIViewController {
    let sectionInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(UINib(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCollectionViewCell")
        imageCollectionView.contentInset = sectionInsets
        
        APIManager.fetch {  [weak self] titles, average in
            DispatchQueue.main.async {
                if let titles = titles, let average = average {
                    for (index, (title, avg)) in zip(titles.indices, zip(titles, average)) {
                        if let cell = self?.imageCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? FeedCollectionViewCell {
                            cell.movieTitle.text = title
                            cell.averageVote.text = String(avg)
                            
                            print(cell)
                        }
                    }
                }
            }
        }
    }
}

extension ImageFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        imageCollectionView.register(UINib(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeedCollectionViewCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as! FeedCollectionViewCell
        
        //cell.imageViewFeed.image = UIImage(named: "splash")
        cell.imageViewFeed.image = UIImage(systemName: "house")
        cell.contentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cell.contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //cell.backgroundColor = .black
        
        return cell
    }
}



extension ImageFeedViewController: UICollectionViewDelegateFlowLayout {
    //셀 사이즈 결정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let itemSpacing: CGFloat = 1 //셀 사이 간격 너비
        let cellWidth: CGFloat = (width - (sectionInsets.left + sectionInsets.right) - (itemSpacing * 2)) / 3
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
