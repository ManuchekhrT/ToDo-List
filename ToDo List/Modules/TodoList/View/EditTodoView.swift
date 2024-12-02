//
//  EditTodoView.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 30.11.2024.
//
import SwiftUI

struct EditTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: TodoListPresenter
    let todo: TodoEntity
    
    @State private var title: String
    @State private var description: String
    
    init(presenter: TodoListPresenter, todo: TodoEntity) {
        self.presenter = presenter
        self.todo = todo
        _title = State(initialValue: todo.title)
        _description = State(initialValue: todo.body)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $title)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                    .foregroundColor(Color.black)
                
                TextField("Описание", text: $description)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                    .foregroundColor(Color.black)
            }
            .foregroundColor(.brown)
            .navigationBarTitle("Редактировать задачу")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        let updatedTask = todo.copy(title: title, body: description)
                        presenter.editTask(todo: updatedTask)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
