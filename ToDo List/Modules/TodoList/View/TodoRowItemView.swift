//
//  TodoRowView.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 30.11.2024.
//

import SwiftUI

struct TodoRowItemView: View {
    let todo: TodoEntity
    let presenter: TodoListPresenter
    
    var body: some View {
        HStack(alignment: .top) {
            
            Button(action: {
                presenter.toggleStatus(for: todo)
            }) {
                ZStack {
                    Circle()
                        .stroke(todo.status ? yellowColor : statusUncompletedColor, lineWidth: 1) // 1px border
                        .frame(width: 26, height: 26)
                    
                    if todo.status {
                        Image(systemName: "checkmark")
                            .foregroundColor(yellowColor)
                            .font(.system(size: 14, weight: .bold))
                    }
                }
            }.buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .font(.headline)
                    .foregroundColor(todo.status ? placeholderColor : activeColor)
                    .strikethrough(todo.status, color: placeholderColor)
                    .lineLimit(1)
                Text(todo.body)
                    .font(.subheadline)
                    .foregroundColor(todo.status ? placeholderColor : activeColor)
                    .padding(EdgeInsets.init(top: 4, leading: 0, bottom: 0, trailing: 0))
                Text(formatDate(todo.createdAt))
                    .font(.caption)
                    .foregroundColor(placeholderColor)
                    .padding(EdgeInsets.init(top: 6, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .padding(.vertical, 8)
        .listRowBackground(primaryBackgroundColor)
    }
}
