//  File.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/22/25.
//
import Foundation
import SwiftData
@Model
class Recipe {
    @Attribute(.unique) var id: UUID
    var name: String
    var category: String
    var ingredients: [String]
    var steps: String
    
    init(name: String, category: String, ingredients: [String], steps: String) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.ingredients = ingredients
        self.steps = steps
    }
}
