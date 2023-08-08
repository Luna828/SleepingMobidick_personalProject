import UIKit

class showMemoController: UIViewController {

    @IBOutlet weak var memoTableView: UITableView!
    
    @IBAction func editMemo(_ sender: Any) {
        performSegue(withIdentifier: "editMemo", sender: nil)
    }
    
    var memo: Memo?
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewMemoController {
            vc.editMemo = memo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: NewMemoController.memoDidChange, object: nil, queue: OperationQueue.main, using: {
            [weak self] (noti) in self?.memoTableView.reloadData()
        })
    }
}
