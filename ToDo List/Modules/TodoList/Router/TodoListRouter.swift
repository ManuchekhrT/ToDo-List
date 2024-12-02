//
//  TodoListRouter.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//

class TodoListRouter {
    static func createModule() -> TodoListView {
        let interactor = TodoListInteractor()
        let presenter = TodoListPresenter(interactor: interactor)
        let view = TodoListView(presenter: presenter)
        return view
    }
}
