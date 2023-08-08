import UIKit

extension MemoTableViewController {
    
    //데이터 정보전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewMemoController {
            if segue.identifier == "newMemo"{
                vc.isEditingMemo = false
            } else if segue.identifier == "showMemo"{
                vc.isEditingMemo = true
                vc.editMemo = DataManager.shared.memoList[index]
            }
        }
    }
    
    //섹션 나누기
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //테이블 뷰 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let deleteMemo = DataManager.shared.memoList.remove(at: indexPath.row)
            DataManager.shared.deleteMemo(deleteMemo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
        performSegue(withIdentifier: "showMemo", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return DataManager.shared.memoList.count
        } else {
            return importantMemo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        memoTableView.register(UINib(nibName: "MemoCell", bundle: nil), forCellReuseIdentifier: "MemoCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        
        let memo = DataManager.shared.memoList[indexPath.row]
        
        cell.memoTitle?.text = memo.content
        cell.memoDate.text = dateFormatter.string(for: memo
            .date)
        
        return cell
    }
}
