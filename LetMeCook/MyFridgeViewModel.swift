//
//  MyFridgeViewModel.swift
//  LetMeCook
//
//  Created by Megan Hu on 12/10/25.
//

import Foundation
import Combine

class MyFridgeViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    @Published var ingredientName: String = ""

    func addIngredient() {
        let trimmed = ingredientName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let newIngredient = Ingredient(name: trimmed)
        ingredients.append(newIngredient)
        ingredientName = ""
    }

    func toggleIngredient(_ ingredient: Ingredient) {
        if let index = ingredients.firstIndex(of: ingredient) {
            ingredients[index].isAvailable.toggle()
        }
    }
}
