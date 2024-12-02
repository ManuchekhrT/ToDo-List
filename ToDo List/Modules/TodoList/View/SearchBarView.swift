//
//  SearchBarView.swift
//  ToDo List
//
//  Created by Manuchekhr Tursunov on 30.11.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(placeholderColor)
                .frame(width: 20, height: 22)
            
            TextField("", text: $text, prompt: Text("Search")
                .foregroundColor(placeholderColor)
                .font(.custom("SF Pro Text", size: 20)))
            .foregroundColor(textColor)
            .font(.custom("SF Pro Text", size: 20))
            
            
            Image(systemName: "mic.fill")
                .foregroundColor(placeholderColor)
                .frame(width: 17, height: 22)
        }
        .padding(EdgeInsets.init(top: 10, leading: 8, bottom: 10, trailing: 8))
        .background(grayColor)
        .cornerRadius(10)
        .padding()
    }
}
