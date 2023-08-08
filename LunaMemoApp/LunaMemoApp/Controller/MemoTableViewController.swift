import UIKit


class MemoTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var memoTableView: UITableView!
    
    @IBAction func showCollectionViewMemo(_ sender: Any) {
        
        performSegue(withIdentifier: "showCollectionView", sender: nil)
    }
    var memo: Memo?
    
    var index = 0
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewMemoController {
            if segue.identifier == "newMemo"{
                vc.isEditingMemo = false
            } else if segue.identifier == "showMemo"{
                vc.isEditingMemo = true
                vc.editMemo = DataManager.shared.memoList[index]
            }
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .orange
        
        self.setupToolBar()
        self.setupToolBarButton()
        
        let didPerformSearch: Bool = false
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        if didPerformSearch == true {
        } else {
            memoTableView.isHidden = false
        }
        
        //observer 추가
        NotificationCenter.default.addObserver(forName: NewMemoController.newMemoInsert, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.tableView.reloadData()})
//        override func viewWillAppear(_ animated: Bool) { // 화면이 새롭게 그려질 때마다 호출됨
//        myTableView.reloadData()
//        self.toolbarItems = makeToolbarItems()
//        dataManager.setData()
//        print("Page2viewWillAppear")
//        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색어가 변경될 때마다 호출되는 메서드
        if searchText.isEmpty {
            // 검색어가 비어있으면 전체 메모를 보여줍니다.
            DataManager.shared.fetchMemo()
        } else {
            // 검색어가 비어있지 않으면 검색 결과를 가져ㅇ
            DataManager.shared.memoList = DataManager.shared.searchMemo(keyword: searchText)
        }
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let deleteMemo = DataManager.shared.memoList.remove(at: indexPath.row)
            DataManager.shared.deleteMemo(deleteMemo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

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
        let addMemo = UIBarButtonItem(title: "", image: UIImage(systemName: "square.and.pencil"), target: self, action: #selector(addNewMemoBtn))
        let title = UIBarButtonItem(title: "\(DataManager.shared.memoList.count)개의 메모", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        
        let barItems = [flexibleSpace, title, flexibleSpace, addMemo]
        
        self.toolbarItems = barItems
        
    }
    
    @objc func addNewMemoBtn(_ sender: Any?){
        performSegue(withIdentifier: "newMemo", sender: nil)
    }
    
    func numberOxfSections(in tableView: UITableView) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
        performSegue(withIdentifier: "showMemo", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManager.shared.memoList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        memoTableView.register(UINib(nibName: "MemoCell", bundle: nil), forCellReuseIdentifier: "MemoCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        
        let memo = DataManager.shared.memoList[indexPath.row]
        
        cell.memoTitle?.text = memo.content
        cell.memoDate.text = formatter.string(for: memo
            .date)
        
        return cell
    }
  
}
