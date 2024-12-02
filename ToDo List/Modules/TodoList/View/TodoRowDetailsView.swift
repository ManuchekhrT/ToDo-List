//
//  TodoDetailsView.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 30.11.2024.
//

import SwiftUI

struct TodoRowDetailsView: View {
    let todo: TodoEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(todo.title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.yellow)
            
            Text(formatDate(todo.createdAt))
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(todo.body)
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(primaryBackgroundColor)
        .navigationTitle("Страница задачи")
        .navigationBarTitleDisplayMode(.inline)
    }
}
