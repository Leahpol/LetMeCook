//
//  ShoppingItem.swift
//  LetMeCook
//
//  Created by Ava Yu on 12/10/25.
//
import Foundation
import SwiftData
@Model
class ShoppingItem {
    var name: String
    var checked: Bool
    
    init(name: String, checked: Bool = false) {
        self.name = name
        self.checked = checked
    }
}

