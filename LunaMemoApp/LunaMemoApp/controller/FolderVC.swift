import UIKit

class FolderTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var folderTableView: UITableView!
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let didPerformSearch: Bool = false
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        if didPerformSearch == true {
        } else {
            folderTableView.isHidden = false
        }
        self.setupToolBar()
        self.setupToolBarButtonFolder()
        
        NotificationCenter.default.addObserver(forName: AddNewFolderController.newFolderInsert, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.tableView.reloadData()})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //table view 목록 업데이트
        DataManager.shared.fetchMemo()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "memoPage", sender: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return Folder.dummyFolderList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        folderTableView.register(UINib(nibName: "FolderCell", bundle: nil), forCellReuseIdentifier: "FolderCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) as! FolderCell
        
        let target = Folder.dummyFolderList[indexPath.row]
        cell.folderLabel.text = target.content

        return cell
    }
    
}
