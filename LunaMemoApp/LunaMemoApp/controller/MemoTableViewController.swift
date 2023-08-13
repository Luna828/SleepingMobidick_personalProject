import UIKit


class MemoTableViewController: UITableViewController {
    
    @IBOutlet var memoTableView: UITableView!
    
    @IBAction func showCollectionViewMemo(_ sender: Any) {
        performSegue(withIdentifier: "showCollectionView", sender: nil)
    }
    
    var memo: Memo?
    var index = 0
    let dateFormatter = DateFormat().formatter
    let sections = ["iCloud","중요한 메모"]
    var importantMemo: [Memo] = []
    var token: NSObjectProtocol?
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //table view 목록 업데이트
        DataManager.shared.fetchMemo()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .orange
        setupToolBar()
        setupToolBarButton()
        
        let didPerformSearch: Bool = false
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        if didPerformSearch == true {
        } else {
            memoTableView.isHidden = false
        }
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCalled(_:)))
        memoTableView.addGestureRecognizer(longPressGesture)
        
        //observer 추가
        NotificationCenter.default.addObserver(forName: NewMemoController.newMemoInsert, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.tableView.reloadData()})
    }
}
