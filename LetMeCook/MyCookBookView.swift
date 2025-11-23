//
//  MyCookBookView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//

import SwiftUI

struct MyCookBookView: View {
    @Binding var recipes: [Recipe]
    @State private var isPresentingAddRecipeSheet = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                        .ignoresSafeArea()
                VStack{
                    Text("My CookBook")
                        .font(.system(size: 50, weight: .bold))
                        .offset(y: 60)
                    Divider()
                    List(recipes) { recipe in
                        Text(recipe.name)
                    }
                    .scrollContentBackground(.hidden)
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
                }
            }
            .sheet(isPresented: $isPresentingAddRecipeSheet) {
                AddRecipeView(recipes: $recipes)
            }
        }
        
    }
}

#Preview {
    MyCookBookPreviewWrapper()
}

struct MyCookBookPreviewWrapper: View {
    @State private var recipes = [
        Recipe(name: "Example", category: "Dinner", ingredients: ["Eggs"], steps: "Mix and cook.")
    ]

    var body: some View {
        MyCookBookView(recipes: $recipes)
    }
}

