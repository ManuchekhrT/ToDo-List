//
//  TodoListInteractorProtocol.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//

import Foundation

protocol TodoListInteractorProtocol {
    func fetchTodos(completion: @escaping ([TodoEntity]) -> Void)
    func deleteTask(id: Int, completion: @escaping () -> Void)
    func addTask(_ task: TodoEntity, completion: @escaping () -> Void)
    func updateTask(_ task: TodoEntity, completion: @escaping () -> Void)
}

class TodoListInteractor: TodoListInteractorProtocol {
    private let coreDataManager = CoreDataManager()
    private let networkManager = NetworkManager()
    private let userDefaults = UserDefaults.standard
    
    func updateTask(_ task: TodoEntity, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.coreDataManager.updateTask(task)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func fetchTodos(completion: @escaping ([TodoEntity]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let todos = self.coreDataManager.fetchTodos()
            
            if todos.isEmpty && !self.hasLoadedFromAPI() {
                self.networkManager.fetchTodos { result in
                    switch result {
                    case .success(let apiTodos):
                        self.coreDataManager.saveTodos(apiTodos)
                        self.setLoadedFromAPI()

                        DispatchQueue.main.async {
                            completion(apiTodos)
                        }
                    case .failure(let error):
                        print("Ошибка при загрузке данных из API: \(error)")
                        DispatchQueue.main.async {
                            completion([])
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(todos)
                }
            }
        }
    }
    
    
    func deleteTask(id: Int, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.coreDataManager.deleteTask(id: id)
            completion()
        }
    }
    
    func addTask(_ task: TodoEntity, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.coreDataManager.saveTask(task)
            completion()
        }
    }
    
    private func hasLoadedFromAPI() -> Bool {
        userDefaults.bool(forKey: "HasLoadedFromAPI")
    }
    
    private func setLoadedFromAPI() {
        userDefaults.set(true, forKey: "HasLoadedFromAPI")
    }
}
