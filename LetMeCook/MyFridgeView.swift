//
//  MyFridgeView.swift
//  LetMeCook
//
//  Created by Megan Hu on 12/10/25.
//

import SwiftUI

struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var isAvailable: Bool = true   // true = in fridge, false = used/out
}


struct MyFridgeView: View {
    @StateObject private var viewModel = MyFridgeViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack{
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    
                    
                    Text("My Fridge")
                        .font(.system(size: 50, weight: .bold))
                        .padding(.top, 50)
                        .padding(.bottom, 10)
                    
                    Divider()
                    
                    
                    // Input bar
                    HStack {
                        TextField("Enter ingredient", text: $viewModel.ingredientName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: viewModel.addIngredient) {
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                                .padding(.horizontal, 24) // wider padding for pill shape
                                .padding(.vertical, 12)
                                .background(viewModel.ingredientName.isEmpty ? Color.gray : Color.black)
                                .cornerRadius(25)
                        }
                        .disabled(viewModel.ingredientName.isEmpty)
                    }
                    
                    // Ingredients list
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // In Fridge section
                            Text("In Fridge")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            ForEach(viewModel.ingredients.filter { $0.isAvailable }) { item in
                                HStack {
                                    Text(item.name)
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .onTapGesture {
                                    viewModel.toggleIngredient(item)
                                }
                            }
                            
                            // Out section
                            Text("Used / Out")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                            
                            ForEach(viewModel.ingredients.filter { !$0.isAvailable }) { item in
                                HStack {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.red)
                                    Text(item.name)
                                        .strikethrough()
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .onTapGesture {
                                    viewModel.toggleIngredient(item)
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

