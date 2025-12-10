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
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // HEADER
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.white)
                            .frame(height: 250)
                        VStack(spacing: 12) {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 120, height: 120)
                            Text("Name")
                                .font(.system(size: 26, weight: .medium))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    Text("My Recipes")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    VStack(spacing: 20) {
                        ForEach(recipes) { recipe in
                            RecipeCard(recipe: recipe)
                        }
                    }
                    .padding(.horizontal)
                    Text("Saved Recipes")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    VStack(spacing: 20) {
                        RecipeCard(recipe: Recipe(
                            name: "Truffle Mac and Cheese",
                            category: "Dinner",
                            ingredients: ["Pasta", "Milk", "Cheese", "Truffle"],
                            steps: "Cook the pasta..."
                        ), showHeart: true)
                        RecipeCard(recipe: Recipe(
                            name: "Cinnamon Rolls",
                            category: "Dessert",
                            ingredients: ["Flour", "Milk", "Eggs", "Butter"],
                            steps: "Mix the dough..."
                        ), showHeart: true)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color("BackgroundColor").ignoresSafeArea())
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { isPresentingAddRecipeSheet.toggle() }) {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .font(.system(size: 30, weight: .medium))
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                }
            )
            .sheet(isPresented: $isPresentingAddRecipeSheet) {
                AddRecipeView(recipes: $recipes)
            }
        }
    }
}
struct RecipeCard: View {
    var recipe: Recipe
    var showHeart: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.name)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Category: \(recipe.category)")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
                Text("Ingredients: \(recipe.ingredients.joined(separator: ", "))")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
            Spacer()
            
            if showHeart {
                Image(systemName: "heart.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }}
