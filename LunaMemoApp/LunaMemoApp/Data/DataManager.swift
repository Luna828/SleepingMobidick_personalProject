//
//  DataManager.swift
//  LunaMemoApp
//
//  Created by t2023-m0050 on 2023/08/03.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    //싱글톤
    static let shared = DataManager()
    private init(){
        
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //메모를 읽어오는 것
    var memoList = [Memo]()
    
    func fetchMemo() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            memoList = try mainContext.fetch(request)
        } catch {
            print("ERROR")
        }
    }
    
    func searchMemo(keyword: String) -> [Memo] {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()

        let predicate = NSPredicate(format: "content CONTAINS[cd] %@", keyword)
        request.predicate = predicate
        
        let sortByDateDesc = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            // Fetch the memos that match the search criteria
            return try mainContext.fetch(request)
        } catch {
            print("ERROR")
            return []
        }
    }
    
    func addNewMemo(_ memo: String?){
        //core data가 만들어준 메모기에 context를 전달
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        newMemo.date = Date()
        
        memoList.insert(newMemo, at: 0)
        
        //데이터를 실제로 저장하고싶다면
        saveContext()
    }
    
    func deleteMemo(_ memo: Memo?){
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LunaMemo")
        container.loadPersistentStores(completionHandler: {
         (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved  error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
