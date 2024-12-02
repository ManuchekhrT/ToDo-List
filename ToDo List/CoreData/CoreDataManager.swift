//
//  CoreDataManager.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    private let context = PersistenceController.shared.container.viewContext

    func saveTodos(_ todos: [TodoEntity]) {
        for todo in todos {
            let todoItem = Item(context: context)
            todoItem.id = Int64(todo.id)
            todoItem.title = todo.title
            todoItem.body = todo.body
            todoItem.created_at = todo.createdAt
            todoItem.status = todo.status
        }
        saveContext()
    }

    func saveTask(_ task: TodoEntity) {
        let todoItem = Item(context: context)
        todoItem.id = Int64(task.id)
        todoItem.title = task.title
        todoItem.body = task.body
        todoItem.created_at = task.createdAt
        todoItem.status = task.status
        saveContext()
    }

    func fetchTodos() -> [TodoEntity] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            let todoItems = try context.fetch(fetchRequest)
            return todoItems.map {
                TodoEntity(
                    id: Int($0.id),
                    title: $0.title ?? "",
                    body: $0.body ?? "",
                    createdAt: $0.created_at ?? Date(),
                    status: $0.status
                )
            }
        } catch {
            print("Failed to fetch todos from CoreData: \(error)")
            return []
        }
    }

    func deleteTask(id: Int) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                context.delete(item)
            }
            saveContext()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }

    func updateTask(_ task: TodoEntity) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", task.id)
        do {
            let items = try context.fetch(fetchRequest)
            if let itemToUpdate = items.first {
                itemToUpdate.title = task.title
                itemToUpdate.body = task.body
                itemToUpdate.status = task.status
                saveContext()
            }
        } catch {
            print("Failed to update task: \(error)")
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
