//
//  TodoEntity.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//
import Foundation

struct TodoEntity: Identifiable {
    let id: Int
    let title: String
    let body: String
    let createdAt: Date
    let status: Bool
    
    func copy(
        id: Int,
        title: String,
        body: String,
        createdAt: Date,
        status: Bool
    ) -> TodoEntity {
        return TodoEntity(
            id: id, title: title, body: body, createdAt: createdAt, status: status
        )
    }
    
    func copy(
        title: String,
        body: String
    ) -> TodoEntity {
        return TodoEntity(
            id: id, title: title, body: body, createdAt: createdAt, status: status
        )
    }
    
    func copy(
        status: Bool
    ) -> TodoEntity {
        return TodoEntity(
            id: id, title: title, body: body, createdAt: createdAt, status: status
        )
    }
}
