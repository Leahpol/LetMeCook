//
//  EditRecipeView.swift
//  LetMeCook
//
//  Created by Ava Yu on 12/10/25.
//
import SwiftUI
import SwiftData
struct EditRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var recipe: Recipe
    
    @State private var ingredient: String = ""
    @State private var editedName: String
    @State private var editedCategory: String
    @State private var editedIngredients: [String]
    @State private var editedSteps: String
    
    let categories = ["Breakfast", "Lunch", "Dinner", "Desssert", "Other"]
    @State private var customCategory = ""
    
    init(recipe: Recipe) {
        self.recipe = recipe
        _editedName = State(initialValue: recipe.name)
        _editedCategory = State(initialValue: recipe.category)
        _editedIngredients = State(initialValue: recipe.ingredients)
        _editedSteps = State(initialValue: recipe.steps)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Recipe Name
                        VStack(alignment: .leading) {
                            Text("Recipe Name")
                                .font(.system(size: 30, weight: .medium))
                            TextField("Enter Name", text: $editedName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Category
                        VStack(alignment: .leading) {
                            Text("Category")
                                .font(.system(size: 30, weight: .medium))
                            Picker("Category", selection: $editedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            if editedCategory == "Other" {
                                TextField("Enter category", text: $customCategory)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .animation(.easeInOut, value: editedCategory)
                                    .onChange(of: customCategory) { oldValue, newValue in
                                        if !newValue.isEmpty {
                                            editedCategory = newValue
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Ingredients
                        VStack(alignment: .leading) {
                            Text("Ingredients")
                                .font(.system(size: 30, weight: .medium))
                            
                            HStack {
                                TextField("Enter Ingredient", text: $ingredient)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                
                                Button(action: {
                                    guard !ingredient.isEmpty, !editedIngredients.contains(ingredient)
                                    else { return }
                                    editedIngredients.append(ingredient)
                                    ingredient = ""
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 30))
                                }
                            }
                            
                            // Ingredients List
                            if !editedIngredients.isEmpty {
                                VStack(spacing: 8) {
                                    ForEach(editedIngredients, id: \.self) { ing in
                                        HStack {
                                            Button(action: {
                                                if let removeIndex = editedIngredients.firstIndex(of: ing) {
                                                    editedIngredients.remove(at: removeIndex)
                                                }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundStyle(.red)
                                                    .font(.system(size: 25))
                                            }
                                            
                                            Text(ing)
                                                .bold()
                                            
                                            Spacer()
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Instructions
                        VStack(alignment: .leading) {
                            Text("Instructions")
                                .font(.system(size: 30, weight: .medium))
                            
                            TextEditor(text: $editedSteps)
                                .padding()
                                .scrollContentBackground(.hidden)
                                .background(Color.white)
                                .cornerRadius(15)
                                .frame(minHeight: 200)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 40)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Edit Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
        recipe.name = editedName
        recipe.category = editedCategory
        recipe.ingredients = editedIngredients
        recipe.steps = editedSteps
    }
}

