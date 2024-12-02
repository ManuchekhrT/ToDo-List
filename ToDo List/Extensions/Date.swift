//
//  Date.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 29.11.2024.
//
import SwiftUI

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.string(from: date)
}
