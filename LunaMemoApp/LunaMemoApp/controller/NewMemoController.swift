//
//  NewMemoController.swift
//  LunaMemoApp
//
//  Created by t2023-m0050 on 2023/08/02.
//

import UIKit

class NewMemoController: UIViewController {
    
    var editMemo: Memo?
    
    @IBOutlet weak var memoTextView: UITextView!
    
    var initialMemoText: String?
    var isEditingMemo = false
    
    
    @IBAction func saveBtn(_ sender: Any) {
        
        guard let memo = memoTextView.text,
              memo.count > 0 else {
            alert(message: "메모를 입력하세요")
            return
        }
        
//        let newMemo = Memo(content: memo, date: Date())
//        Memo.dummyMemoList.append(newMemo)
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
