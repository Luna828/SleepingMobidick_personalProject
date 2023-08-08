import UIKit

extension MemoTableViewController {
    
    @objc func longPressCalled(_ longPress: UILongPressGestureRecognizer) {
        
        let indexInCell = longPress.location(in: memoTableView)
        let indexPath = memoTableView.indexPathForRow(at: indexInCell)
        
        if longPress.state == .began {
            showLongPressAlert(for: indexPath)
        }
    }
    private func showLongPressAlert(for indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
        
        let memoContent = DataManager.shared.memoList[indexPath.row].content ?? ""
        let alertController = UIAlertController(title: "중요한 메모를 추가하시겠습니까?", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.importantMemo.append(memoContent)
            self.memoTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
