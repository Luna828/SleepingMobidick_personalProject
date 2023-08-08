import UIKit

extension UIViewController {
    
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
    
    func setupToolBarButtonFolder() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let addFolder = UIBarButtonItem(title: "", image: UIImage(systemName: "folder.badge.plus"), target: self,action: #selector(addNewFolderBtn))
        let addMemo = UIBarButtonItem(title: "", image: UIImage(systemName: "square.and.pencil"), target: self, action: #selector(addNewMemoBtn))
        
        let barItems = [addFolder, flexibleSpace, flexibleSpace, flexibleSpace, addMemo]
        self.toolbarItems = barItems
    }
    
    @objc func addNewMemoBtn(_ sender: Any?){
        // self는 현재 인스턴스를 가리키는 키워드 (self를 사용하여 해당 인스턴스의 멤버들에게 접근 가능)
        if self is MemoTableViewController {
            performSegue(withIdentifier: "newMemo", sender: nil)
        } else if self is FolderTableViewController {
            performSegue(withIdentifier: "addNewMemo", sender: nil)
        }
    }
    
    //새 폴더 segue (modal 형식)
    @objc func addNewFolderBtn(_ sender: Any?){
        performSegue(withIdentifier: "addFolder", sender: nil)
    }
}
