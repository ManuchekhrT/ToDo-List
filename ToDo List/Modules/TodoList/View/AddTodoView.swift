//
//  AddTodoView.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 30.11.2024.
//
import SwiftUI

struct AddTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: TodoListPresenter
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $title)
                    .padding(EdgeInsets.init(top: 8, leading: 10, bottom: 8, trailing: 10))
                    .foregroundColor(Color.black)
                
                TextField("Описание", text: $description)
                    .padding(EdgeInsets.init(top: 8, leading: 10, bottom: 8, trailing: 10))
                    .foregroundColor(Color.black)
            }
            .foregroundColor(.brown)
            .navigationBarTitle("Новая задача")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        presenter.addTask(title: title, body: description)
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
