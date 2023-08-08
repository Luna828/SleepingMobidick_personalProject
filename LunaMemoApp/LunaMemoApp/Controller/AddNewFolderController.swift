import UIKit

class AddNewFolderController: UITableViewController {
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        guard let folderName = FolderNameTextField.text, !folderName.isEmpty else {
            return
        }
        
        print("Folder name: \(folderName)")
        let newFolder = Folder(content: folderName)
        Folder.dummyFolderList.append(newFolder)
        
        NotificationCenter.default.post(name: AddNewFolderController.newFolderInsert, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    private let FolderNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "폴더명을 입력해주세요."
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FolderNameTextField.placeholder = "새 폴더명을 입력해주세요"
        FolderNameTextField.borderStyle = .roundedRect
        
        view.backgroundColor = .systemGray5
        
        view.addSubview(FolderNameTextField)
        FolderNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            FolderNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FolderNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            FolderNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            FolderNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

extension AddNewFolderController {
    static let newFolderInsert = Notification.Name(rawValue: "new Folder")
}
