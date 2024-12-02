//
//  TodoListView.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//

import SwiftUI

struct TodoListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var presenter: TodoListPresenter
    
    @State private var isAddingTask = false
    @State private var selectedTodo: TodoEntity? = nil
    
    var body: some View {
        NavigationView {
            if presenter.todos.isEmpty {
                ListViewEmpty()
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    topHeader
                    SearchBarView(text: $presenter.searchText)
                    ListView(presenter: presenter)
                    bottomFooter
                }
                .background(primaryBackgroundColor)
            }
        }
        .navigationTitle("Задачи")
        .sheet(isPresented: $isAddingTask) {
            AddTodoView(presenter: presenter)
        }
        .background(primaryBackgroundColor.ignoresSafeArea())
    }
    
    var topHeader: some View {
        HStack {
            Text("Задачи")
                .font(.largeTitle)
                .bold()
                .foregroundColor(textColor)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 15)
    }
    
    var bottomFooter: some View {
        HStack(alignment: .center) {
            Spacer()
            
            Text("\(presenter.todos.count) задач")
                .font(.footnote)
                .foregroundColor(textColor)
            
            Spacer()
        }.overlay(
            Button(action: {
                isAddingTask = true
            }) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(yellowColor)
            }.padding(.trailing, 16),
            alignment: .trailing
        )
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets.init(top: 20, leading: 0, bottom: 20, trailing: 0))
        .background(grayColor)
    }
}

struct ListViewEmpty: View {
    var body: some View {
        VStack {
            Text("Нет задач")
                .foregroundColor(textColor)
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .background(primaryBackgroundColor.ignoresSafeArea())
    }
}

struct ListView: View {
    @ObservedObject var presenter: TodoListPresenter
    
    @State private var selectedTodo: TodoEntity? = nil
    @State private var isEditingTask = false
    
    var body: some View {
        List {
            ForEach(presenter.filteredTodos) { todo in
                NavigationLink(destination: TodoRowDetailsView(todo: todo)) {
                    TodoRowItemView(todo: todo, presenter: presenter)
                }
                .listRowBackground(primaryBackgroundColor)
                .contextMenu {
                    Button(action: {
                        selectedTodo = todo
                    }) {
                        Label("Редактировать", systemImage: "pencil")
                    }
                    Button(action: {
                        presenter.shareTask(todo: todo)
                    }) {
                        Label("Поделиться", systemImage: "square.and.arrow.up")
                    }
                    Button(role: .destructive, action: {
                        presenter.deleteTask(id: todo.id)
                    }) {
                        Label("Удалить", systemImage: "trash")
                    }
                }
            }
            .onDelete(perform: { indexSet in
                guard let index = indexSet.first else { return }
                let task = presenter.todos[index]
                presenter.deleteTask(id: task.id)
            })
        }
        .listStyle(PlainListStyle())
        .background(primaryBackgroundColor)
        .sheet(item: $selectedTodo) { todo in
            EditTodoView(presenter: presenter, todo: todo)
        }
    }
}
