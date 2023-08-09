import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
            fetch { [weak self] titles in
                DispatchQueue.main.async {
                    if let firstTitle = titles?.first {
                        self?.test.text = firstTitle
                    }
                }
            }
        }
}
