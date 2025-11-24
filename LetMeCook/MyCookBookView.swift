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
    
    var groupedRecipes: [String: [Recipe]] {
        Dictionary(grouping: recipes, by: { $0.category })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    Text("My CookBook")
                        .font(.system(size: 50, weight: .bold))
                        .padding(.top, 50)
                        .padding(.bottom, 20)
                    
                    Divider()
                    List {
                        ForEach(
                            groupedRecipes.keys.sorted {
                                $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
                            },
                            id: \.self
                        ) { category in
                            
                            Section {
                                ForEach(groupedRecipes[category]!) { recipe in
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        Text(recipe.name)
                                            .font(.system(size: 20))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, 4)
                                    }
                                }
                            } header: {
                                Text(category)
                                    .font(.system(size: 28, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 16)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: .infinity)
                    .layoutPriority(1)
                }
                .safeAreaInset(edge: .bottom) {
                    Button(action: {
                        isPresentingAddRecipeSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 30, weight: .medium))
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black.opacity(0.5), lineWidth: 2)
                            )
                    }
                    .padding(.bottom, 10)
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
