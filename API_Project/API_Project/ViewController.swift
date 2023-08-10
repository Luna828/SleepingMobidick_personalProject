import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.fetch { [weak self] titles, average in
            DispatchQueue.main.async {
                if let firstTitle = titles?.first {
                    self?.test.text = firstTitle
                }
            }
        }
    }
}
