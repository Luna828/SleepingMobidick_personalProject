import UIKit

struct DummyData {
    let img: UIImage
    let name: String
}

class ViewController: UIViewController, UISearchBarDelegate {
    

    
    @IBOutlet weak var settingTableView: UITableView!
    
    let profileName: String = "Luna Kim"
    
    let sections = ["","","",""]
    
    let networkList = [
        DummyData(img: (UIImage(systemName: "wifi") ?? UIImage(systemName: "nil"))!, name: "Wi-Fi"),
        DummyData(img: (UIImage(systemName: "shareplay") ?? UIImage(systemName: "person"))!, name: "Bluetooth"),
        DummyData(img: (UIImage(systemName: "antenna.radiowaves.left.and.right") ?? UIImage(systemName: "person"))!, name: "셀룰러"),
        DummyData(img: (UIImage(systemName: "personalhotspot") ?? UIImage(systemName: "person"))!, name: "개인용 핫스팟"),
    ]
    
    let notificationList = [
        DummyData(img: (UIImage(systemName: "bell.badge") ?? UIImage(systemName: "nil"))!, name: "알림"),
        DummyData(img: (UIImage(systemName: "headphones.circle") ?? UIImage(systemName: "nil"))!, name: "사운드 및 햅틱"),
        DummyData(img: (UIImage(systemName: "powersleep") ?? UIImage(systemName: "nil"))!, name: "집중 모드"),
        DummyData(img: (UIImage(systemName: "hourglass") ?? UIImage(systemName: "nil"))!, name: "스크린 타임"),
    ]
    
    let contentList = [
        DummyData(img: (UIImage(systemName: "gearshape") ?? UIImage(systemName: "nil"))!, name: "알반"),
        DummyData(img: (UIImage(systemName: "switch.2") ?? UIImage(systemName: "nil"))!, name: "제어 센터"),
        DummyData(img: (UIImage(systemName: "sun.min") ?? UIImage(systemName: "nil"))!, name: "디스플레이 및 밝기"),
        DummyData(img: (UIImage(systemName: "circle.grid.3x3.fill") ?? UIImage(systemName: "nil"))!, name: "홈 화면"),
        DummyData(img: (UIImage(systemName: "person.2.circle") ?? UIImage(systemName: "nil"))!, name: "손쉬운 사용"),
        DummyData(img: (UIImage(systemName: "display") ?? UIImage(systemName: "nil"))!, name: "배경화면"),
        DummyData(img: (UIImage(systemName: "magnifyingglass") ?? UIImage(systemName: "nil"))!, name: "Siri 및 검색"),
        DummyData(img: (UIImage(systemName: "key") ?? UIImage(systemName: "nil"))!, name: "Face ID 및 암호"),
        DummyData(img: (UIImage(systemName: "light.beacon.min.fill") ?? UIImage(systemName: "nil"))!, name: "긴급 구조 요청"),
        DummyData(img: (UIImage(systemName: "battery.75") ?? UIImage(systemName: "nil"))!, name: "배터리"),
        DummyData(img: (UIImage(systemName: "lock.square") ?? UIImage(systemName: "nil"))!, name: "개인정보 및 보안"),
    ]
    
    //section의 개수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let didPerformSearch: Bool = false
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        if didPerformSearch == true {
        }else{
            settingTableView.isHidden = false
        }
        
        //아주중요
        //settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //테이블뷰의 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return networkList.count + 1
        } else if section == 2 {
            return notificationList.count
        } else if section == 3 {
            return contentList.count
        }
        return 0
    }
    
    // 각 쎌에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        settingTableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        
        
        if indexPath.section == 0 {
            //profile 셀 등록
            settingTableView.register(UINib(nibName: "TableViewNameCell", bundle: nil), forCellReuseIdentifier: "TableViewNameCell")
            settingTableView.rowHeight = UITableView.automaticDimension
            settingTableView.estimatedRowHeight = 120
            
            let cell = settingTableView.dequeueReusableCell(withIdentifier: "TableViewNameCell", for: indexPath) as! TableViewNameCell
            cell.profileImg.image = UIImage(systemName: "person")
            cell.userNameLabel.text = profileName
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else if indexPath.section == 1 {
            settingTableView.register(UINib(nibName: "toggleCell", bundle: nil), forCellReuseIdentifier: "toggleCell")
            settingTableView.rowHeight = UITableView.automaticDimension
            settingTableView.estimatedRowHeight = 120
            
            if indexPath.row == 0 {
                let toggleCell = settingTableView.dequeueReusableCell(withIdentifier: "toggleCell", for: indexPath) as! toggleCell
                
                return toggleCell
            } else {
                cell.settingImg.image = networkList[indexPath.row - 1].img
                cell.settingLabel.text = networkList[indexPath.row - 1].name
                cell.accessoryType = .disclosureIndicator
                
                return cell
            }
        } else if indexPath.section == 2 {
            
            cell.settingImg.image = notificationList[indexPath.row].img
            cell.settingLabel.text = notificationList[indexPath.row].name
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            
            cell.settingImg.image = contentList[indexPath.row].img
            cell.settingLabel.text = contentList[indexPath.row].name
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
    }
}
