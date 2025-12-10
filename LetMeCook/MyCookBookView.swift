//  MyCookBookView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//
import SwiftUI
import SwiftData

struct MyCookBookView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.category) private var recipes: [Recipe]
    @State private var isPresentingAddRecipeSheet = false
    @State private var editMode: EditMode = .inactive
    
    var groupedRecipes: [String: [Recipe]] {
        Dictionary(grouping: recipes, by: { $0.category })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
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
                                .onDelete { indexSet in
                                    deleteRecipes(at: indexSet, in: category)
                                }
                            } header: {
                                Text(category)
                                    .font(.system(size: 28, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 16)
                            }
                        }
                    }
                    .environment(\.editMode, $editMode)
                    .scrollContentBackground(.hidden)
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
                AddRecipeView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            if editMode == .inactive {
                                editMode = .active
                            } else {
                                editMode = .inactive
                            }
                        }
                    }) {
                        Text(editMode == .inactive ? "Edit" : "Done")
                            .font(.system(size: 17, weight: .medium))
                    }
                }
            }
        }
    }
    
    private func deleteRecipes(at offsets: IndexSet, in category: String) {
        guard let recipesInCategory = groupedRecipes[category] else { return }
        
        for index in offsets {
            let recipeToDelete = recipesInCategory[index]
            modelContext.delete(recipeToDelete)
        }
    }
}

#Preview {
    MyCookBookView()
        .modelContainer(for: Recipe.self)
}
