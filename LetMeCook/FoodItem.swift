//
//  FoodItem.swift
//  LetMeCook
//
//  Created by Ava Yu on 12/10/25.
//
import Foundation
import SwiftData
@Model
class FoodItem {
    var name: String
    var quantity: Int
    
    init(name: String, quantity: Int = 1) {
        self.name = name
        self.quantity = quantity
    }
}
