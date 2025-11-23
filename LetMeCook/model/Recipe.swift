//
//  File.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/22/25.
//

import Foundation
struct Recipe: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var category: String
    var ingredients: [String]
    var steps: String
}
