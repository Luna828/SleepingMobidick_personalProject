import UIKit

class FolderTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var folderTableView: UITableView!
    
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
        self.setupToolBarButton()
        
        NotificationCenter.default.addObserver(forName: AddNewFolderController.newFolderInsert, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.tableView.reloadData()})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //table view 목록 업데이트
        DataManager.shared.fetchMemo()
        tableView.reloadData()
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }

    //toolBar 생성
    func setupToolBar(){
        navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.tintColor = UIColor.orange
    }
    
    func setupAppearance(){
        let appearance = UIToolbarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.toolbar.scrollEdgeAppearance = appearance
    }
    
    func setupToolBarButton() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let addFolder = UIBarButtonItem(title: "", image: UIImage(systemName: "folder.badge.plus"), target: self,action: #selector(addNewFolderBtn))
        let addMemo = UIBarButtonItem(title: "", image: UIImage(systemName: "square.and.pencil"), target: self, action: #selector(addNewMemoBtn))
        
        let barItems = [addFolder, flexibleSpace, flexibleSpace, flexibleSpace, addMemo]
        self.toolbarItems = barItems
    }
    
    //새 폴더 segue (modal 형식)
    @objc func addNewFolderBtn(_ sender: Any?){
//        let addNewFolderController = AddNewFolderController()
//            self.present(addNewFolderController, animated: true, completion: nil)
        performSegue(withIdentifier: "addFolder", sender: nil)
    }
    
    //새 메모로 가는 segue
    @objc func addNewMemoBtn(_ sender: Any?){
        performSegue(withIdentifier: "addNewMemo", sender: nil)
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
