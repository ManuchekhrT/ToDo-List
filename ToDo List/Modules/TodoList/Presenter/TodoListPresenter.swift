//
//  TodoListPresenter.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//
import Foundation

protocol TodoListPresenterProtocol: ObservableObject {
    var todos: [TodoEntity] { get set }
    var searchText: String { get set }
    
    func loadTodos()
    func deleteTask(at indexSet: IndexSet)
    func deleteTask(id: Int)
    func addTask(title: String, body: String)
    func toggleStatus(for todo: TodoEntity)
    func editTask(todo: TodoEntity)
    func shareTask(todo: TodoEntity)
}

class TodoListPresenter: TodoListPresenterProtocol {
    
    @Published var todos: [TodoEntity] = [] {
        didSet {
            updateFilteredTodos()
        }
    }
    
    @Published var searchText: String = "" {
        didSet {
            updateFilteredTodos()
        }
    }
    
    @Published private(set) var filteredTodos: [TodoEntity] = []

    private func updateFilteredTodos() {
        if searchText.isEmpty {
            filteredTodos = todos
        } else {
            filteredTodos = todos.filter { todo in
                todo.title.lowercased().contains(searchText.lowercased()) ||
                todo.body.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func toggleStatus(for todo: TodoEntity) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let updatedTask = todo.copy(status: !todo.status)
            self?.interactor.updateTask(updatedTask) { [weak self] in
                DispatchQueue.main.async {
                    if let index = self?.todos.firstIndex(where: {$0.id == todo.id }) {
                        self?.todos[index] = updatedTask
                    }
                }
                
            }
        }
    }
    
    func editTask(todo: TodoEntity) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let updatedTask = todo
            self?.interactor.updateTask(updatedTask) { [weak self] in
                DispatchQueue.main.async {
                    if let index = self?.todos.firstIndex(where: { $0.id == todo.id }) {
                        self?.todos[index] = updatedTask
                    }
                }
            }
        }
    }
    
    // Поделиться задачей
    func shareTask(todo: TodoEntity) {
        let taskDetails = """
            Задача: \(todo.title)
            Описание: \(todo.body)
            Дата: \(todo.createdAt)
            Статус: \(todo.status ? "Выполнено" : "Не выполнено")
            """
        print("Поделиться задачей:\n\(taskDetails)") // Здесь можно реализовать логику для ShareSheet
    }
    

    private let interactor: TodoListInteractorProtocol
    
    init(interactor: TodoListInteractorProtocol) {
        self.interactor = interactor
        loadTodos()
    }
    
    func loadTodos() {
        interactor.fetchTodos { [weak self] result in
            DispatchQueue.main.async {
                self?.todos = result
            }
        }
    }
    
    func deleteTask(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let task = todos[index]
        interactor.deleteTask(id: task.id) { [weak self] in
            DispatchQueue.main.async {
                self?.todos.remove(at: index)
            }
        }
    }
    
    
    func addTask(title: String, body: String) {
        let newTask = TodoEntity(id: Int.random(in: 1...9999), title: title, body: body, createdAt: Date(), status: false)
        interactor.addTask(newTask) { [weak self] in
            self?.loadTodos()
        }
    }
    
    func deleteTask(id: Int) {
        interactor.deleteTask(id: id) { [weak self] in
            DispatchQueue.main.async {
                self?.todos.removeAll { $0.id == id }
            }
        }
    }
}
