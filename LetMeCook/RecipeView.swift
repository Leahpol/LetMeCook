//
//  RecipeView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    
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
                    
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                    
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                    }
                    
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                    
                    Text(recipe.steps)
                        .padding(.top, 5)
                    
                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
