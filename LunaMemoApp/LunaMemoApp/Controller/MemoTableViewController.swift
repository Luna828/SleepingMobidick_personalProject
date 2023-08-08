import UIKit


class MemoTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var memoTableView: UITableView!
    
    @IBAction func showCollectionViewMemo(_ sender: Any) {
        
        performSegue(withIdentifier: "showCollectionView", sender: nil)
    }
    var memo: Memo?
    
    let sections = ["iCloud","중요한 메모"]
    
    var importantMemo: [String] = []
    
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
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCalled(_:)))
        memoTableView.addGestureRecognizer(longPressGesture)
        
        //observer 추가
        NotificationCenter.default.addObserver(forName: NewMemoController.newMemoInsert, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.tableView.reloadData()})
    }
    
    // longPress 제스처가 시작되었을 때만 코드 실행
    @objc func longPressCalled(_ longPress: UILongPressGestureRecognizer){
        print("longPress called")
        
        let indexInCell = longPress.location(in: memoTableView)
        let indexPath = memoTableView.indexPathForRow(at: indexInCell)
        
        if longPress.state == .began {
            let alertController = UIAlertController(title: "중요한 메모를 추가하시겠습니까?", message: "", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                if let indexPath = indexPath {
                    let memoContent = DataManager.shared.memoList[indexPath.row].content ?? ""
                    self.importantMemo.append(memoContent)
                    self.memoTableView.reloadData()
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
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
        if section == 0 {
            return DataManager.shared.memoList.count
        } else {
            return importantMemo.count
        }
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
