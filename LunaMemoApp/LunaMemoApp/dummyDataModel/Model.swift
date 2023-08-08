//
//  Model.swift
//  LunaMemoApp
//
//  Created by t2023-m0050 on 2023/08/01.
//

import Foundation

//class Memo {
//    var content: String
//    var date: Date
//    
//    init(content: String, date: Date) {
//        self.content = content
//        self.date = date
//    }
//    
//    static var dummyMemoList = [
//        Memo(content: "은행 예금하기", date: Date()),
//        Memo(content: "낮잠 자야함", date: Date())
//    ]
//}

class Folder {
    var content: String
    
    init(content: String) {
        self.content = content
    }
    
    static var dummyFolderList = [
        Folder(content: "iCloud"),
//        Folder(content: "메모")
    ]
}


