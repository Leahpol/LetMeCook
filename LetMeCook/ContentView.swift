//  SwiftUIView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//
import SwiftUI
import SwiftData
struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                NavigationBar()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .offset(y: -100)
            }
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Recipe.self)
}
