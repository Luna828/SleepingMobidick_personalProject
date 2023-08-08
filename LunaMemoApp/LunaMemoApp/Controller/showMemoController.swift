//
//  showMemoController.swift
//  LunaMemoApp
//
//  Created by t2023-m0050 on 2023/08/02.
//

import UIKit

class showMemoController: UIViewController {

    var memo: Memo?
  
    @IBOutlet weak var memoTableView: UITableView!
    
    @IBAction func editMemo(_ sender: Any) {
        performSegue(withIdentifier: "editMemo", sender: nil)
    }
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewMemoController {
            vc.editMemo = memo
        }
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: NewMemoController.memoDidChange, object: nil, queue: OperationQueue.main, using: {
            [weak self] (noti) in self?.memoTableView.reloadData()
        })
        
    }
    
}

extension showMemoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //몇번째 셀
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memo", for: indexPath)
            
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.date)
            return cell
        default :
            fatalError()
        }
    }
}
