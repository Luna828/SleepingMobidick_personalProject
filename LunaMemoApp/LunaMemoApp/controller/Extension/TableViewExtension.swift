import UIKit

extension MemoTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색어가 변경될 때마다 호출되는 메서드
        if searchText.isEmpty {
            // 검색어가 비어있으면 전체 메모를 보여줍니다.
            DataManager.shared.fetchMemo()
        } else {
            // 검색어가 비어있지 않으면 검색 결과를 가져ㅇ
            DataManager.shared.memoList = DataManager.shared.searchMemo(keyword: searchText)
        }
        tableView.reloadData()
    }
}
