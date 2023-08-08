import UIKit

class NewMemoController: UIViewController {
    
    var editMemo: Memo?
    var initialMemoText: String?
    var isEditingMemo = false
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBAction func saveBtn(_ sender: Any) {
        
        guard let memo = memoTextView.text,
              memo.count > 0 else {
            alert(message: "메모를 입력하세요")
            return
        }

        if let target = editMemo {
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: NewMemoController.memoDidChange, object: nil)
        } else {
            DataManager.shared.addNewMemo(memo)
            NotificationCenter.default.post(name: NewMemoController.newMemoInsert, object: nil)
        }
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .orange
    
        if isEditingMemo, let memo = editMemo {
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
        } else {
            navigationItem.title = "새 메모"
            memoTextView.text = initialMemoText
        }

    }
    
}

extension NewMemoController {
    static let newMemoInsert = Notification.Name(rawValue: "new Memo")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
