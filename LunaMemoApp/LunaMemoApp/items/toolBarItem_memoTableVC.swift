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
    
    @objc func addNewMemoBtn(_ sender: Any?){
        performSegue(withIdentifier: "newMemo", sender: nil)
    }
    
}
