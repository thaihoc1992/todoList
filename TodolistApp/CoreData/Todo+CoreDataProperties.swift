//
//  Todo+CoreDataProperties.swift
//  TodolistApp
//
//  Created by ADMIN on 6/24/21.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var time: Date?
    @NSManaged public var title: String?

}

extension Todo : Identifiable {
    // Thêm một todo vào database
    static func addNewTodo(title: String, content: String, isComplete: Bool, time: Date) -> Todo? {
        let todo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: AppDelegate.managerObjectContext!) as! Todo
        todo.id = UUID().uuidString
        todo.title = title
        todo.content = content
        todo.isCompleted = isComplete
        todo.time = time
        
        // tiến hành lưu todo
        do {
            try AppDelegate.managerObjectContext?.save()
            print("Thêm mới todo thành công")
        } catch {
            let nsError = error as NSError
            print("Không thể thêm mới todo, lỗi: \(nsError)")
            return nil
        }
        
        return todo
    }
    
    static func getAllTodos() -> [Todo]{
        var results = [Todo]()
        let moc = AppDelegate.managerObjectContext
        
        do {
            results = try moc!.fetch(Todo.fetchRequest()) as! [Todo]
        } catch {
            let nsError = error
            print("Không thể lấy danh sách, \(nsError)")
            return results
        }
        return results
    }
    
    static func deleteTodoByID(id: String){
        let moc = AppDelegate.managerObjectContext
        let todos = Todo.getAllTodos()
        for item in todos{
            if item.id == id {
                moc?.delete(item)
            }
        }
        do {
            try AppDelegate.managerObjectContext?.save()
            
        } catch {
            let nsError = error as NSError
            print("Không thể xoá vì \(nsError)")
            return
        }
        print("Xoá todo thành công")
    }
    static func editTodoByID(id: String, newTitle: String, newContent: String){
        let todos = Todo.getAllTodos()
        for item in todos{
            if item.id == id {
                item.title = newTitle
                item.content = newContent
            }
        }
        do {
            try AppDelegate.managerObjectContext?.save()
            
        } catch {
            let nsError = error as NSError
            print("Không thể edit vì \(nsError)")
            return
        }
        print("Edit todo thành công")
    }
    
    static func changeStatusTodoByID(id: String){
        let todos = Todo.getAllTodos()
        for item in todos{
            if item.id == id {
                item.isCompleted = !item.isCompleted
            }
        }
        do {
            try AppDelegate.managerObjectContext?.save()
            
        } catch {
            let nsError = error as NSError
            print("Không thể thay đổi vì \(nsError)")
            return
        }
        print("Thay đổi todo thành công")
    }
    
    static func searchItem(_ query: String) -> [Todo] {
        var array = [Todo]()
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS %@", query)
        fetchRequest.predicate = predicate
        let moc = AppDelegate.managerObjectContext
        do {
            let fetchResult = try moc!.fetch(fetchRequest)
            array = fetchResult
        } catch {
            print(error.localizedDescription)
        }
        return array
    }
}

