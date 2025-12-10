



//
//  AddRecipeView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//
import SwiftUI
struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @State var newName: String = ""
    @State var ingredient: String = ""
    @State var steps = ""
    @State var selectedCategory = "Breakfast"
    @State private var newClassingredients = [String]()
    @Binding var recipes: [Recipe]
    let categories = ["Breakfast", "Lunch", "Dinner", "Dessert", "Other"]
    @State private var customCategory = ""
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .offset(x: -160, y: 10)
                Text("Recipe Name")
                    .font(.system(size: 30, weight: .medium))
                    .offset(x: -93, y: 15)
                TextField("Enter Name", text: $newName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .foregroundColor(.black)
                Divider()
                Text("Category")
                    .font(.system(size: 30, weight: .medium))
                    .offset(x: -120, y: 15)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                if selectedCategory == "Other" {
                    TextField("Enter category", text: $customCategory)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .animation(.easeInOut, value: selectedCategory)
                }
                Divider()
                Text("Ingredients")
                    .font(.system(size: 30, weight: .medium))
                    .offset(x: -110, y: 15)
                HStack {
                    TextField("Enter Ingredient", text: $ingredient)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    Button(action: {
                        guard !ingredient.isEmpty, !newClassingredients.contains(ingredient)
                              else { return }
                        newClassingredients.append(ingredient)
                        ingredient = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                    }
                    .offset(x: -15)
                }
                List(newClassingredients, id: \.self) { ing in
                    HStack {
                        Button(action: {
                            if let removeIndex = newClassingredients.firstIndex(of: ing) {
                                newClassingredients.remove(at: removeIndex)
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 30))
                        }
                        .offset(x: +15)
                        Text(ing)
                            .bold()
                            .offset(x: +15)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                Divider()
                Text("Instructions")
                    .font(.system(size: 30, weight: .medium))
                    .offset(x: -105, y: 15)
                ZStack{
                    TextEditor(text: $steps)
                        .padding()
                        .background(Color.white)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.black)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    if steps.isEmpty {
                        Text("Enter Steps here")
                            .foregroundColor(.gray.opacity(0.4))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                    }
                }
                Divider()
                Button(action: {
                    guard !newName.isEmpty, !steps.isEmpty, !newClassingredients.isEmpty  else { return }
                        let newRecipe = Recipe(
                            name: newName,
                            category: selectedCategory == "Other" ? customCategory : selectedCategory,
                            ingredients: newClassingredients,
                            steps: steps
                        )
                        recipes.append(newRecipe)
                        dismiss()
                    }) {
                    Text("Save")
                        .font(.system(size: 23, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: 70, maxHeight: 40)
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
            }
            
        }
    }
        
    
    func dismissAddClassView() {
        dismiss()
    }
}
#Preview {
    AddRecipePreviewWrapper()
}
struct AddRecipePreviewWrapper: View {
    @State private var recipes = [Recipe]()
    var body: some View {
        AddRecipeView(recipes: $recipes)
    }
}

