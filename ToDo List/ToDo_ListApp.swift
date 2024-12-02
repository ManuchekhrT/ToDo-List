//
//  ToDo_ListApp.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//

import SwiftUI

@main
struct ToDo_ListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TodoListView(presenter: makePresenter())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    private func makePresenter() -> TodoListPresenter {
        let interactor = TodoListInteractor()
        
        return TodoListPresenter(interactor: interactor)
    }
}
