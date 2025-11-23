//
//  RecipeView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//

import SwiftUI

struct RecipeView: View {
    @State private var recipes: [Recipe] = []
    var body: some View {
        ZStack {
            NavigationBar(recipes: $recipes)
        }
    }
}

#Preview {
    RecipeView()
}
