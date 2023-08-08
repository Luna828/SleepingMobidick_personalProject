import UIKit

class showMemoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionview 설정
        //myCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        //myCollectionView.contentInset = sectionInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //table view 목록 업데이트
        DataManager.shared.fetchMemo()
    }
    
 //sectionInsets의 공간 만큼 추가되기 때문에 cell이 벌려짐 (전체 패딩) = viewDidLoad()의 myCollectionView.contentInset = sectionInsets 랑 같음
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return sectionInsets
    }
    
    // 각 콜렉션뷰 쎌 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! memoClass
        
        cell.collectionBtn.setTitle(DataManager.shared.memoList[indexPath.row].content, for: .normal)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(DataManager.shared.memoList.count)
        return DataManager.shared.memoList.count
    }
}


extension showMemoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    //셀 사이즈를 결정해주는 코드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let itemSpacing: CGFloat = 10 //셀 사이 간격 너비
        let cellWidth: CGFloat = (width - (sectionInsets.left + sectionInsets.right) - (itemSpacing * 2)) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

class memoClass: UICollectionViewCell {
    @IBOutlet weak var collectionBtn: UIButton!
}
