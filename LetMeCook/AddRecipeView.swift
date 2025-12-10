//  AddRecipeView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//
import SwiftUI
import SwiftData

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var newName: String = ""
    @State var ingredient: String = ""
    @State var steps = ""
    @State var selectedCategory = "Breakfast"
    @State private var newClassingredients = [String]()
    @State private var customCategory = ""

    let categories = ["Breakfast", "Lunch", "Dinner", "Desssert", "Other"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Recipe Name
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Recipe Name")
                                .font(.system(size: 30, weight: .medium))
                            
                            TextField("Enter Name", text: $newName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Category
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Category")
                                .font(.system(size: 30, weight: .medium))
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            if selectedCategory == "Other" {
                                TextField("Enter category", text: $customCategory)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .animation(.easeInOut, value: selectedCategory)
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Ingredients
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Ingredients")
                                .font(.system(size: 30, weight: .medium))
                            
                            HStack {
                                TextField("Enter Ingredient", text: $ingredient)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                
                                Button(action: {
                                    guard !ingredient.isEmpty,
                                          !newClassingredients.contains(ingredient)
                                    else { return }
                                    
                                    newClassingredients.append(ingredient)
                                    ingredient = ""
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 30))
                                }
                            }
                            
                            if !newClassingredients.isEmpty {
                                VStack(spacing: 8) {
                                    ForEach(newClassingredients, id: \.self) { ing in
                                        HStack {
                                            Button(action: {
                                                if let removeIndex = newClassingredients.firstIndex(of: ing) {
                                                    newClassingredients.remove(at: removeIndex)
                                                }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundStyle(.red)
                                                    .font(.system(size: 25))
                                            }
                                            
                                            Text(ing).bold()
                                            Spacer()
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Instructions
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Instructions")
                                .font(.system(size: 30, weight: .medium))
                            
                            ZStack(alignment: .topLeading) {
                                if steps.isEmpty {
                                    Text("Enter Steps here")
                                        .foregroundColor(.gray.opacity(0.4))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 16)
                                }
                                
                                TextEditor(text: $steps)
                                    .padding(8)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .frame(minHeight: 200)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer().frame(height: 40)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Add Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                // Top-left X button (matching Save button style)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
                
                // Top-right Save button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        guard !newName.isEmpty,
                              !steps.isEmpty,
                              !newClassingredients.isEmpty
                        else { return }
                        
                        let newRecipe = Recipe(
                            name: newName,
                            category: selectedCategory == "Other" ? customCategory : selectedCategory,
                            ingredients: newClassingredients,
                            steps: steps
                        )
                        
                        modelContext.insert(newRecipe)
                        dismiss()
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium))
                }
            }
        }
    }
}
