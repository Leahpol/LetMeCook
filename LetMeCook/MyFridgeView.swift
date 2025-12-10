//
//  MyFridgeView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//
import SwiftUI
import SwiftData
struct MyFridgePageView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \FoodItem.name) private var fridgeItems: [FoodItem]
    @Query(sort: \ShoppingItem.name) private var shoppingList: [ShoppingItem]
    
    @State private var newFridgeItem = ""
    @State private var newShoppingItem = ""
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    List {
                        // MARK: - My Fridge
                        Section(
                            header: Text("My Fridge")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                        ) {
                            
                            // Add fridge item manually
                            HStack {
                                TextField("Add item to fridge…", text: $newFridgeItem)
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                
                                Button("Add") {
                                    guard !newFridgeItem.isEmpty else { return }
                                    modelContext.insert(FoodItem(name: newFridgeItem))
                                    newFridgeItem = ""
                                }
                            }
                            
                            ForEach(fridgeItems) { item in
                                HStack {
                                    Text(item.name)
                                        .font(.system(size: 20, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Button {
                                        modelContext.delete(item)
                                    } label: {
                                        Image(systemName: "trash.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 28))
                                    }
                                }
                            }
                        }
                        
                        // MARK: - Shopping List
                        Section(
                            header: Text("Shopping List")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                        ) {
                            
                            HStack {
                                TextField("Add item to shopping list…", text: $newShoppingItem)
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                
                                Button("Add") {
                                    guard !newShoppingItem.isEmpty else { return }
                                    modelContext.insert(ShoppingItem(name: newShoppingItem))
                                    newShoppingItem = ""
                                }
                            }
                            
                            ForEach(shoppingList) { item in
                                HStack {
                                    Button {
                                        item.checked.toggle()
                                    } label: {
                                        Image(systemName: item.checked ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(item.checked ? .green : .gray)
                                            .font(.system(size: 24))
                                    }
                                    
                                    Text(item.name)
                                        .font(.system(size: 20))
                                        .strikethrough(item.checked)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    // MARK: - MOVE CHECKED ITEMS BUTTON
                    if shoppingList.contains(where: { $0.checked }) {
                        Button(action: moveCheckedItemsToFridge) {
                            Text("Move Checked Items to Fridge")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .medium))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black.opacity(0.5), lineWidth: 2)
                                )
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                    }
                }
            }
            .navigationTitle("My Fridge")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Move all checked items
    private func moveCheckedItemsToFridge() {
        let checkedItems = shoppingList.filter { $0.checked }
        
        for item in checkedItems {
            if !fridgeItems.contains(where: { $0.name.lowercased() == item.name.lowercased() }) {
                modelContext.insert(FoodItem(name: item.name))
            }
            modelContext.delete(item)
        }
    }
}
