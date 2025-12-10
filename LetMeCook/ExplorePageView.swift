//  ExplorePageView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//
import SwiftUI
import SwiftData
struct ExplorePageView: View {
    @State private var isPresentingAddRecipeSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack{
                    Button(action: {
                        isPresentingAddRecipeSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 30, weight: .medium))
                            .padding()
                            .background(Color.white.opacity(1))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black.opacity(0.5), lineWidth: 2))
                    }
                    .offset(y: 325)
                }
                .navigationTitle("Search For recipes")
                .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(isPresented: $isPresentingAddRecipeSheet) {
                AddRecipeView()
            }
        }
    }
}
#Preview {
    ExplorePageView()
        .modelContainer(for: Recipe.self)
}

