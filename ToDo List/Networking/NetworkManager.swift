//
//  NetworkManager.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 27.11.2024.
//

import Foundation

class NetworkManager {
    private let baseURL = "https://dummyjson.com"

    // Fetch todos from API
    func fetchTodos(completion: @escaping (Result<[TodoEntity], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(TodoAPIResponse.self, from: data)
                let todos = decodedResponse.todos.map {
                    TodoEntity(
                        id: $0.id,
                        title: "Title from #\($0.userId)",
                        body: $0.todo,
                        createdAt: Date(),
                        status: $0.completed
                    )
                }
                completion(.success(todos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// API Response Models
struct TodoAPIResponse: Decodable {
    let todos: [TodoAPIItem]
}

struct TodoAPIItem: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

// Custom Error
enum NetworkError: Error {
    case invalidURL
    case noData
}

