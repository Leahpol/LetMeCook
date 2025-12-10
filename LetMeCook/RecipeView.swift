//  RecipeView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//
import SwiftUI
import SwiftData

struct RecipeView: View {
    @Bindable var recipe: Recipe
    @State private var isPresentingEditSheet = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Category: \(recipe.category)")
                        .font(.headline)
                    
                    Divider()
                    
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            Text("• \(ingredient)")
                                .font(.body)
                        }
                    }
                    
                    Divider()
                    
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                    
                    Text(recipe.steps)
                        .font(.body)
                        .padding(.top, 5)
                    
                    Spacer()
                        .frame(height: 50)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingEditSheet = true
                }) {
                    Text("Edit")
                        .font(.system(size: 17, weight: .medium))
                }
            }
        }
        .sheet(isPresented: $isPresentingEditSheet) {
            EditRecipeView(recipe: recipe)
        }
    }
}
